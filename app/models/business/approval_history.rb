# frozen_string_literal: true

class Business::ApprovalHistory < ApplicationRecord
  belongs_to :business
  belongs_to :managed_by, class_name: 'Client', optional: true
  belongs_to :requested_by, class_name: 'Admin', optional: true

  scope :unresolved, -> { where(resolved: false).order(created_at: :desc) }
end
