# frozen_string_literal: true

class AddBusinessToBusinessRewards < ActiveRecord::Migration[7.0]
  def change
    add_reference :business_rewards, :business, null: true, foreign_key: true, type: :uuid
  end
end
