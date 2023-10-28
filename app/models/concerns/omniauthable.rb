# frozen_string_literal: true

module Omniauthable
  extend ActiveSupport::Concern

  class_methods do
    def from_omniauth(access_token, resource)
      data = access_token.info

      omniauth = Omniauth.find_or_initialize_by(provider: access_token['provider'],
                                                uid: access_token['uid'])

      existing_acc = resource.find_by(email: data['email'])
      user = omniauth.user || resource.find_by(email: data['email'])

      # Link existing account to new omniauth
      if existing_acc.present? && omniauth.user.blank?
        omniauth.info = access_token.to_json
        omniauth.user = user
        omniauth.save
      end

      unless user
        user = resource.create(
          first_name: data['first_name'] || data['name'], # Use 'name' for Twitter if 'first_name' isn't available
          last_name: data['last_name'],
          email: data['email'],
          password: Devise.friendly_token[0, 20]
        )
        image = Down.download(data['image'])
        user.avatar.attach(io: image, filename: 'avatar.jpg')

        omniauth.info = access_token.to_json
        omniauth.user = user
        omniauth.save
      end

      user
    end

    def link_omniauth(access_token, params, resource)
      data = access_token.info
      existing_user_id = params['user_id']

      user = resource.find(existing_user_id)

      @omniauth = Omniauth.find_or_initialize_by(provider: access_token['provider'],
                                                 uid: access_token['uid'])

      omniauths_providers = user.omniauths.map(&:provider)

      unless omniauths_providers.include?(access_token['provider'])
        @omniauth.info = access_token.to_json
        @omniauth.user = user
        @omniauth.save
      end

      unless user
        user = resource.create(
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
