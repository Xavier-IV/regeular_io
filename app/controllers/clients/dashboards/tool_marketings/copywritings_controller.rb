# frozen_string_literal: true

class Clients::Dashboards::ToolMarketings::CopywritingsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @histories = current_client.business.ai_results
                               .where(kind: 'ai.marketing.generative.copywriting')
                               .where(created_at: 7.days.ago..Time.zone.now)
                               .order(created_at: :desc)
  end

  def new
    business = current_client.business
    limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.copywriting')
    consumption_count = business.business_token_consumptions
                                .where(kind: 'ai.marketing.generative.copywriting')
                                .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                .count

    @percentage = consumption_count.present? ? ((limit.limit.to_f - consumption_count.to_f) / limit.limit.to_f) * 100 : 100.0
    @balance = "#{[(limit.limit - consumption_count), 0].max}/#{limit.limit}"
    @balance_left = limit.limit - consumption_count
    @result = business.ai_results.where(kind: 'ai.marketing.generative.copywriting').order(created_at: :desc).first
  end

  def create
    @result = nil

    # TODO: check if in quota
    business = current_client.business
    token_limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.copywriting')

    if token_limit.limit_by == 'weekly'
      consumptions = business.business_token_consumptions
                             .where(kind: 'ai.marketing.generative.copywriting')
                             .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                             .count

      if consumptions >= token_limit.limit
        return redirect_to new_clients_dashboards_tool_marketings_copywriting_path,
                           alert: 'You\'ve reached the quota for this week.'
      end
    end

    begin
      client = OpenAI::Client.new
      messages = [
        { role: 'system',
          content: ''"
You are a content editor for company named '#{current_client.business.name}'.
ONLY give response.
"'' },
        { role: 'user',
          content: ''"
Provide a copywriting for my business named #{current_client.business.name}.
Result in accurate local Bahasa Melayu in Malaysia, max 30 words.
Do not mix with Indonesian word.
"'' }
      ]

      http_response = client.chat(
        parameters: {
          model: current_client.business.business_subscription.model_plan,
          messages:,
          temperature: 0.7
        }
      )

      @result = http_response.dig('choices', 0, 'message', 'content')

      business.business_token_consumptions.create(
        kind: 'ai.marketing.generative.copywriting'
      )
      ai_result = business.ai_results.create(
        kind: 'ai.marketing.generative.copywriting',
        input_text: messages,
        output_text: @result&.strip || nil,
        api_response: http_response,
        user_id: current_client.id
      )

      ai_result.save
      redirect_to new_clients_dashboards_tool_marketings_copywriting_path, success: 'Copywriting generated!'
    rescue StandardError
      redirect_to new_clients_dashboards_tool_marketings_copywriting_path, success: 'Oh oh. Something went wrong.'
    end
  end
end
