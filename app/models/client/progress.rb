# frozen_string_literal: true

class Client::Progress < Progress
  belongs_to :client, foreign_key: :user_id, inverse_of: :client_progresses

  validates :progress_type, inclusion: {
    in: %w[onboarding.get_started onboarding.verified_email onboarding.has_logo onboarding.has_listing_image
           onboarding.has_operating_hours onboarding.has_gmap_link],
    message: 'must be one of the accepted values.'
  }

  def self.onboarded?(keys)
    where(progress_type: keys)
  end
end
