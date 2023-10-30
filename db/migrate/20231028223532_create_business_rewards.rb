# frozen_string_literal: true

class CreateBusinessRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :business_rewards, id: :uuid do |t|
      t.string :kind
      t.float :value
      t.references :created_by, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :updated_by, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.boolean :is_active
      t.datetime :deactivated_at

      t.timestamps
    end
  end
end
