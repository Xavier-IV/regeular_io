# frozen_string_literal: true

class User < ApplicationRecord
  include Omniauthable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable,
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter]

  serialize :roles, Array

  has_many :reviews, dependent: :destroy
  belongs_to :business, optional: true

  has_one_attached :avatar

  scope :regular, lambda {
    joins(:reviews)
      .group('users.id')
      .having('COUNT(reviews.id) >= ?', 5)
  }

  def is_regular?
    reviews.count >= 5
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
