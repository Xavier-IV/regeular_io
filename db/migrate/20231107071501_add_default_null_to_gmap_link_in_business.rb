# frozen_string_literal: true

class AddDefaultNullToGmapLinkInBusiness < ActiveRecord::Migration[7.0]
  def change
    change_column_default :businesses, :gmap_link, from: nil, to: nil
  end
end
