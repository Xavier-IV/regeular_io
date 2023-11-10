# frozen_string_literal: true

class Client < User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :confirmable, :lockable, :trackable,
         :invitable

  after_create :assign_default_role

  has_many :customer_progresses, foreign_key: :user_id, dependent: :destroy, inverse_of: false
  has_many :client_progresses, class_name: 'Client::Progress', inverse_of: :client, foreign_key: 'user_id',
                               dependent: :destroy

  def assign_default_role
    return unless role.empty? || role == 'anonymous'

    self.role = 'owner'
    save
  end

  def owner?
    role == 'owner'
  end
end
