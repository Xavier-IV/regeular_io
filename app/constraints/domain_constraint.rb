# frozen_string_literal: true

class DomainConstraint
  def initialize(domains)
    @domains = domains.flatten
    domains.each do |domain|
      @domains.push(domain?(domain) ? "staging.#{domain}" : "staging-#{domain}")
    end
    @domains.push('127.0.0.1')
    @domains.push('localhost')
    Rails.logger.debug @domains
  end

  def matches?(request)
    @domains.include? request.domain
  end

  private

  def domain?(string)
    parts = string.split('.')
    parts.length < 3
  end
end
