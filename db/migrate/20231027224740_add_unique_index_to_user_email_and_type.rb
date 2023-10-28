# frozen_string_literal: true

class AddUniqueIndexToUserEmailAndType < ActiveRecord::Migration[7.0]
  def change
    add_index :users, %i[email type], unique: true
  end
end
