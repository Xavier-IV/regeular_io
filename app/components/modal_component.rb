# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(title:)
    super
    @title = title
  end
end
