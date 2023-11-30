# frozen_string_literal: true

class Client::PushSubscription < PushSubscription
  belongs_to :client, foreign_key: 'user_id', inverse_of: false
end
