# frozen_string_literal: true

class Customer::PushSubscription < PushSubscription
  belongs_to :customer, foreign_key: 'user_id', inverse_of: false
end
