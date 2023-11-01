# frozen_string_literal: true

class RemoveUniqueConstraintFromBusiness < ActiveRecord::Migration[7.0]
  def change
    remove_index :businesses, :registration_id
  end
end
