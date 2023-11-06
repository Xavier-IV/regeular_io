# frozen_string_literal: true

class AddGmapLinkToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :gmap_link, :string, null: true
  end
end
