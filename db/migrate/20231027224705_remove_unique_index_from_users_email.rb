# frozen_string_literal: true

class RemoveUniqueIndexFromUsersEmail < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :email
  end
end
