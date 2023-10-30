# frozen_string_literal: true

class Customer::Reward < ApplicationRecord
  self.table_name = 'customer_rewards'
  belongs_to :business_reward, class_name: 'Business::Reward'
  belongs_to :business
  belongs_to :customer, optional: true
end
