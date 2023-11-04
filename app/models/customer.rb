# frozen_string_literal: true

class Customer < User
  has_one_attached :avatar

  has_many :customer_rewards, class_name: 'Customer::Reward', dependent: :destroy,
                              foreign_key: 'user_id', inverse_of: false
  has_many :customer_progresses, class_name: 'Customer::Progress', dependent: :destroy,
                                 foreign_key: 'user_id', inverse_of: false

  after_create :assign_default_role

  def assign_default_role
    return unless role.empty? || role == 'anonymous'

    self.role = 'customer'
    save
  end
end
