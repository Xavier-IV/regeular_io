# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
