# frozen_string_literal: true

class AddQrCodeReviewToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :qr_code, null: true, foreign_key: true, type: :uuid
  end
end
