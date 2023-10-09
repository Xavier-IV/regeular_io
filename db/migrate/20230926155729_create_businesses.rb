# frozen_string_literal: true

class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses, id: :uuid do |t|
      t.string :name
      t.string :registration_id
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country

      t.timestamps
    end
  end
end
