# frozen_string_literal: true

class Customer::Progress < ApplicationRecord
  self.table_name = 'customer_progresses'
  belongs_to :user
  belongs_to :business
end
