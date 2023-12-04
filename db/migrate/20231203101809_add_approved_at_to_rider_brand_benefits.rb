# frozen_string_literal: true

class AddApprovedAtToRiderBrandBenefits < ActiveRecord::Migration[7.0]
  def change
    add_column :rider_brand_benefits, :approved_at, :datetime
  end
end
