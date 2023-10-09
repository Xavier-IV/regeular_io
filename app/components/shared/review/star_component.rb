# frozen_string_literal: true

class Shared::Review::StarComponent < ViewComponent::Base
  def initialize(role:)
    super
    @role_color = case role
                  when :star
                    'text-yellow-400'
                  else
                    'text-gray-300'
                  end
  end
end
