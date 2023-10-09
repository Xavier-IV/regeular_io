# frozen_string_literal: true

class AddUniqueConstraintToBusinessRegistrationId < ActiveRecord::Migration[7.0]
  def change
    add_index :businesses, :registration_id, unique: true
  end
end
