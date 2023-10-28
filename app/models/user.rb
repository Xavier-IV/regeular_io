# frozen_string_literal: true

class User < ApplicationRecord
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :confirmable, :lockable, :trackable

  validates :email, presence: true, uniqueness: { scope: :type },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Invalid email format' }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: { if: :password_required? }

  has_one_attached :avatar
  has_many :omniauths, dependent: :destroy, inverse_of: :user

  # Client
  belongs_to :business, optional: true

  # Customer
  has_many :reviews, dependent: :destroy
  scope :regular, lambda {
    joins(:reviews)
      .group('users.id')
      .having('COUNT(reviews.id) >= ?', 5)
  }

  # From Devise module Validatable
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  # From Devise module Validatable
  def email_required?
    true
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'owner' || role == 'admin'
  end

  def omniauth_accounts
    omniauths.map(&:provider)
  end
end
