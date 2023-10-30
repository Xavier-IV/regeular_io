# frozen_string_literal: true

class Customer::Progress < ApplicationRecord
  self.table_name = 'customer_progresses'
  belongs_to :user
  belongs_to :business

  after_update :update_leveling

  def gain_exp
    return unless experience < 5 && level < 5

    update(experience: experience + 1)
  end

  private

  def update_leveling
    return unless experience >= 5 && level < 5

    update(experience: 0, level: level + 1)
  end
end
