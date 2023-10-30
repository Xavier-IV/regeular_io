# frozen_string_literal: true

class AddUniqueIndexToBusinessRewards < ActiveRecord::Migration[7.0]
  def change
    add_index :business_rewards, %i[kind business_id], unique: true
  end
end
