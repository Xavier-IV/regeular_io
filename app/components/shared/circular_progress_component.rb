# frozen_string_literal: true

class Shared::CircularProgressComponent < ViewComponent::Base
  def initialize(options = {})
    super

    @percent = options[:percent] || 10
    @value = options[:value] || nil
    @progress_bg = options[:progress_bg]
    @progress_color = options[:progress_color]
    @fill_color = options[:fill_color]

    @stroke_width = 10
    @r = 44

    @stroke_width = 5 if options[:type] == 'secondary'
    @r = 45 if options[:type] == 'secondary'
  end
end
