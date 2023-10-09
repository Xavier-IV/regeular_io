# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.integer :rating
      t.text :description
      t.references :business, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
