# frozen_string_literal: true

class Client < User
  devise :invitable

  after_create :assign_default_role

  def assign_default_role
    return unless role.empty? || role == 'anonymous'

    self.role = 'owner'
    save
  end
end
