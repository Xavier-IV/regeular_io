# frozen_string_literal: true

class Review < ApplicationRecord
  self.table_name = 'reviews'
  belongs_to :business
  belongs_to :customer, optional: true, foreign_key: 'user_id', inverse_of: false
  has_one :qr_code_review, class_name: 'QrCode', dependent: :destroy

  scope :anon, -> { where(user_id: nil) }
  scope :by_business, ->(business_id) { where(business_id:) }

  after_create :update_customer_progress

  private

  def update_customer_progress
    business = self.business
    customer_id = user_id

    ratings = self.class.where(business_id: business.id).map(&:rating)
    rating_average = ratings.reduce(:+).to_f / ratings.length

    progress = Customer::Progress.find_or_create_by(user_id: customer_id, business:)
    progress.rating_average = rating_average
    progress.rating_count = ratings.length

    progress.save

    return unless (progress.rating_count % 5).zero?

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
        capped_amount: reward.capped_amount
      )
    end
  end
end
