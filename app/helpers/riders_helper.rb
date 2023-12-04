# frozen_string_literal: true

module RidersHelper
  def upvoted?(my_votes, benefit_id)
    result = my_votes.find { |vote| vote.rider_brand_benefit_id == benefit_id }
    return false if result.blank? || result.direction.blank?

    result.direction.positive?
  end

  def downvoted?(my_votes, benefit_id)
    result = my_votes.find { |vote| vote.rider_brand_benefit_id == benefit_id }
    return false if result.blank? || result.direction.blank?

    result.direction.negative?
  end
end
