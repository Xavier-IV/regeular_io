# frozen_string_literal: true

class CreateBusinessApprovalHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :business_approval_histories, id: :uuid do |t|
      t.references :business, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.text :client_remark
      t.text :system_remark
      t.boolean :resolved, null: false, default: false
      t.references :requested_by, foreign_key: { to_table: :users }, type: :uuid
      t.references :managed_by, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
