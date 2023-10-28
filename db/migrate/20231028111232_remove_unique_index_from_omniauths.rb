# frozen_string_literal: true

class RemoveUniqueIndexFromOmniauths < ActiveRecord::Migration[7.0]
  def up
    remove_index :omniauths, column: %i[provider uid]
  end

  def down
    add_index :omniauths, %i[provider uid], unique: true
  end
end
