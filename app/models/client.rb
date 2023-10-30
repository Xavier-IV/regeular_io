# frozen_string_literal: true

class Client < User
  devise :invitable

  after_create :assign_default_role

  has_many :customer_progresses, foreign_key: :user_id, dependent: :destroy, inverse_of: false

  def assign_default_role
    return unless role.empty? || role == 'anonymous'

    self.role = 'owner'
    save
  end
end
