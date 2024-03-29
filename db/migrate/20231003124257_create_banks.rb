# frozen_string_literal: true

class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks, id: :uuid do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end
