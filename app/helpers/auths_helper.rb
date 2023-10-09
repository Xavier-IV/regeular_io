# frozen_string_literal: true

module AuthsHelper
  def omniauth_name(name)
    case name
    when :google_oauth2
      'Google'
    else
      OmniAuth::Utils.camelize(name)
    end
  end

  def omniauth_logo(name)
    case name
    when :google_oauth2
      'Google.svg'
    when :twitter
      'Twitter.svg'
    else
      OmniAuth::Utils.camelize(name)
    end
  end
end
