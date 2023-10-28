# frozen_string_literal: true

class CreateOmniauths < ActiveRecord::Migration[7.0]
  def change
    create_table :omniauths, id: :uuid do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.text :info

      t.timestamps
    end

    add_index :omniauths, %i[provider uid], unique: true
  end
end
