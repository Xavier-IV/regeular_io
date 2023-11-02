# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  renders_one :header_icon
  renders_one :primary_action

  def initialize(title:)
    super
    @title = title
  end
end
