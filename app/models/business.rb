# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :business_bank, dependent: :destroy
  has_one :business_statistic, class_name: 'Business::Statistic', dependent: :destroy

  has_many :clients, dependent: :destroy
  has_many :products, class_name: 'Business::Product', dependent: :destroy

  has_one_attached :logo
  has_one_attached :listing

  has_one :qr_code_bank, class_name: 'QrCode::Bank', dependent: :destroy
  has_many :qr_code_review, class_name: 'QrCode::Review', dependent: :destroy
  has_many :qr_code_reward, class_name: 'QrCode::Reward', dependent: :destroy

  has_many :reviews, dependent: :destroy, class_name: 'Review'
  has_many :reviewers, -> { distinct }, through: :reviews, source: :customer, class_name: 'User'

  # Gratifications
  has_many :customer_progresses, class_name: 'Customer::Progress', dependent: :destroy, inverse_of: false
  has_many :customer_rewards, class_name: 'Customer::Reward', dependent: :destroy, inverse_of: false
  has_many :business_rewards, class_name: 'Business::Reward', dependent: :destroy

  scope :listed, lambda {
    joins(:listing_attachment).distinct.joins(:logo_attachment).distinct
                              .joins(:clients)
                              .where(clients: { role: 'owner' })
                              .where.not(clients: { confirmed_at: nil })
                              .where.not(approved_at: nil)

  }

  scope :most_regular, lambda { |truthy|
                         if truthy
                           includes(:business_statistic).order('business_statistics.regular_rating_average DESC NULLS LAST')
                         end
                       }
  scope :most_rating, lambda { |truthy|
                        if truthy
                          includes(:business_statistic).order('business_statistics.customer_rating_average DESC NULLS LAST')
                        end
                      }
  scope :with_state, ->(state) { where(state:) if state.present? }
  scope :with_city, ->(city) { where(city:) if city.present? }

  after_create :prepare_statistic
  after_update :prepare_statistic

  validates :registration_id, uniqueness: true, presence: true, if: -> { registration_id.present? }

  def anon_reviews
    reviews.where(user_id: nil)
  end

  def owner
    clients.find_by(role: 'owner')
  end

  private

  def prepare_statistic
    Business::Statistic.find_or_create_by(business_id: id)
  end
end
