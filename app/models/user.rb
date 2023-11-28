# frozen_string_literal: true

class User < ApplicationRecord
  include Omniauthable

  validates :email, presence: true, uniqueness: { scope: :type, case_sensitive: true },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Invalid email format' }

  # https://github.com/heartcombo/devise/blob/main/lib/devise/models/validatable.rb
  validates :password, presence: { if: :password_required? }
  validates :password, confirmation: { if: :password_required? }
  validates :password, length: { within: (6..128), allow_blank: true }

  has_one_attached :avatar
  has_many :omniauths, dependent: :destroy
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
    return nil if first_name.blank? && last_name.blank?

    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'owner' || role == 'admin'
  end

  def omniauth_accounts
    omniauths.map(&:provider)
  end
end
