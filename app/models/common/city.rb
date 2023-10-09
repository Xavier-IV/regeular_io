# frozen_string_literal: true

class Common::City < ApplicationRecord
  belongs_to :state, class_name: 'Common::State'
end
