# frozen_string_literal: true

class User < ApplicationRecord
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :reviews, dependent: :destroy
  belongs_to :business, optional: true

  has_one_attached :avatar

  scope :regular, lambda {
    joins(:reviews)
      .group('users.id')
      .having('COUNT(reviews.id) >= ?', 5)
  }

  def full_name
    "#{first_name} #{last_name}"
  end
end
