# frozen_string_literal: true

class Rider < User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :confirmable, :lockable, :trackable

  has_one_attached :avatar

  after_create :assign_default_role

  def assign_default_role
    return unless role.empty? || role == 'anonymous'

    self.role = 'rider'
    save
  end
end
