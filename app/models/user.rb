# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable,
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter]

  enum role: { anonymous: 0, customer: 1, business: 2 }

  has_many :reviews, dependent: :destroy
  belongs_to :business, optional: true

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(first_name: data['first_name'],
                         last_name: data['last_name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20])
      image = Down.download(data['image'])
      Rails.logger.debug "IMAGE??? #{data['image']}"
      user.avatar.attach(io: image, filename: 'avatar.jpg')
    end
    user
  end

  def self.from_omniauth_twitter(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(first_name: data['name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20])
      image = Down.download(data['image'])
      Rails.logger.debug "IMAGE??? #{data}"
      user.avatar.attach(io: image, filename: 'avatar.jpg')
    end
    user
  end
end
