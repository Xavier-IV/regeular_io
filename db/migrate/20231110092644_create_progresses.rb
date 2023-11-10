# frozen_string_literal: true

class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :type
      t.string :progress_type
      t.datetime :completed_at

      t.timestamps
    end
  end
end
