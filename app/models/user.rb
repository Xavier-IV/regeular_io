# frozen_string_literal: true

class User < ApplicationRecord
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

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
