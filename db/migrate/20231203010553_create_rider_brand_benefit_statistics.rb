# frozen_string_literal: true

class CreateRiderBrandBenefitStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :rider_brand_benefit_statistics, id: :uuid do |t|
      t.references :rider_brand, null: false, foreign_key: true, type: :uuid
      t.references :rider_brand_benefit, null: false, foreign_key: true, type: :uuid
      t.integer :total_votes

      t.timestamps
    end
  end
end
