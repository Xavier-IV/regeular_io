# frozen_string_literal: true

class Admin < User
  devise :database_authenticatable,
         :recoverable, :rememberable,
         :confirmable, :lockable, :trackable,
         :invitable

  after_create :assign_default_role

  def assign_default_role
    return unless role.empty? || role == 'anonymous'

    self.role = 'member'
    save
  end
end
