# frozen_string_literal: true

class Customer::CheckIn < ApplicationRecord
  self.table_name = 'customer_check_ins'
  belongs_to :user
  belongs_to :business
end
