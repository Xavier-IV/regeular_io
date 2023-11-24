class AddCategoryToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :category, :string
  end
end
