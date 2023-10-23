module Omniauthable
  extend ActiveSupport::Concern

  class_methods do
    def from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      unless user
        user = User.create(
          first_name: data['first_name'] || data['name'], # Use 'name' for Twitter if 'first_name' isn't available
          last_name: data['last_name'],
          email: data['email'],
          password: Devise.friendly_token[0, 20]
        )
        image = Down.download(data['image'])
        user.avatar.attach(io: image, filename: 'avatar.jpg')
      end
      user
    end
  end
end