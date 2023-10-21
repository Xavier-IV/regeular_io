class AddUserIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :user, null: true, foreign_key: true, type: :uuid
  end
end
