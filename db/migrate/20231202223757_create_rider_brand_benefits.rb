# frozen_string_literal: true

class CreateRiderBrandBenefits < ActiveRecord::Migration[7.0]
  def change
    create_table :rider_brand_benefits, id: :uuid do |t|
      t.text :description, null: false
      t.references :rider_brand, null: false, foreign_key: true, type: :uuid
      t.references :created_by, null: false, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
