# frozen_string_literal: true

class CreateAiResults < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_results, id: :uuid do |t|
      t.string :kind
      t.text :input_text
      t.text :output_text
      t.text :api_response
      t.references :business, null: true, foreign_key: true, type: :uuid
      t.references :user, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
