# frozen_string_literal: true

class Review < ApplicationRecord
  self.table_name = 'reviews'
  belongs_to :business
  belongs_to :customer, optional: true, foreign_key: 'user_id', inverse_of: false
  has_one :qr_code_review, class_name: 'QrCode', dependent: :destroy

  scope :anon, -> { where(user_id: nil) }
  scope :by_business, ->(business_id) { where(business_id:) }
  scope :latest, -> { order(created_at: :desc).first }

  after_create :update_customer_progress, :update_business_statistic

  private

  def update_business_statistic
    business = self.business

    statistic = Business::Statistic.find_or_create_by(business:)

    cust_ratings = self.class.where(business_id: business.id).map(&:rating)
    cust_rating_average = cust_ratings.reduce(:+).to_f / cust_ratings.length
    cust_rating_count = cust_ratings.size

    statistic.customer_rating_average = ((cust_rating_average * cust_rating_count) + rating) / (cust_rating_count + 1)
    statistic.total_customer = cust_rating_count + 1

    if user_id.present?
      # Calculate regular rating
      regular_user_ids = business.customer_progresses.where('level > ?', 0).select('user_id')

      if regular_user_ids.present?
        regular_ratings = self.class
                              .where(business_id: business.id)
                              .where(user_id: regular_user_ids).map(&:rating)
        regular_rating_average = regular_ratings.reduce(:+).to_f / regular_ratings.length
        regular_rating_count = regular_ratings.size

        statistic.regular_rating_average = ((regular_rating_average * regular_rating_count) + rating) / (regular_rating_count + 1)
        statistic.total_regular = regular_user_ids.count
      end
    end
    statistic.save
  end

  def update_customer_progress
    business = self.business
    customer_id = user_id

    ratings = self.class.where(business_id: business.id).map(&:rating)
    rating_average = ratings.reduce(:+).to_f / ratings.length

    progress = Customer::Progress.find_or_create_by(user_id: customer_id, business:)
    progress.rating_average = rating_average
    progress.rating_count = ratings.length

    progress.save

    progress.gain_exp

    return unless (progress.rating_count % 5).zero?

    qr_code = self.business.qr_code_reward.create
    rewards = self.business.business_rewards
    rewards.each do |reward|
      Customer::Reward.create(
        kind: reward.kind,
        value: reward.value,
        value_type: reward.value_type,
        given_at: DateTime.now,
        business_reward_id: reward.id,
        business:,
        user_id:,
        min_order_amount: reward.min_order_amount,
        capped_amount: reward.capped_amount,
        qr_code_id: qr_code.id
      )
    end
  end
end
