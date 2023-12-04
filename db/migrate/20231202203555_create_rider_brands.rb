# frozen_string_literal: true

class CreateRiderBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :rider_brands, id: :uuid do |t|
      t.string :name
      t.string :text_color
      t.string :brand_color
      t.string :slug

      t.timestamps
    end
  end
end
