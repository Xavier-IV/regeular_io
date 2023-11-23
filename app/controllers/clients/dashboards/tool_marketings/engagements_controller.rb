# frozen_string_literal: true

class Clients::Dashboards::ToolMarketings::EngagementsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @histories = current_client.business.ai_results
                               .where(kind: 'ai.marketing.generative.engagement')
                               .where(created_at: 7.days.ago..Time.zone.now)
                               .order(created_at: :desc)
  end

  def new
    business = current_client.business
    limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.engagement')
    consumption_count = business.business_token_consumptions
                                .where(kind: 'ai.marketing.generative.engagement')
                                .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                .count

    @percentage = if consumption_count.positive?
                    ([(limit.limit - consumption_count),
                      0].max / limit.limit.to_f) * 100
                  else
                    100.0
                  end
    @balance = "#{[(limit.limit - consumption_count), 0].max}/#{limit.limit}"
    @balance_left = limit.limit - consumption_count
    @result = business.ai_results.where(kind: 'ai.marketing.generative.engagement').order(created_at: :desc).first
  end

  def create
    @result = nil

    business = current_client.business
    token_limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.engagement')

    if token_limit.limit_by == 'weekly'
      consumptions = business.business_token_consumptions
                             .where(kind: 'ai.marketing.generative.engagement')
                             .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                             .count

      if consumptions >= token_limit.limit
        return redirect_to new_clients_dashboards_tool_marketings_engagement_path,
                           alert: 'You\'ve reached the quota for this week.'
      end
    end

    begin
      client = OpenAI::Client.new
      messages = [
        { role: 'system',
          content: ''"
You are a content strategies for company named '#{current_client.business.name}'.
ONLY give response.
"'' },
        { role: 'user',
          content: ''"
My company name is #{current_client.business.name}.
I'm a business owner and would like to make my business viral.
Give me social media idea that can make my customer engage, for example:
- Ask them a quiz that they can participate
- Give free discount
- Provide giveaway
- Ask follower what are their childhood nostalgic memories (so the comment section
flooded with comments and interaction).
- Share a photo of my business and ask follower what the person in
photo is doing, but gives wrong answer only (so the comment section
flooded with comments and interaction).
You can also ask something not related to my business at  times, for example:
- What's your favorite aiskrim malaysia flavour?
- What's your favorite candy during childhood?
- What the best hotwheels,yu-gi-oh,toys etc that you remember?
Limit 30 words, ONLY gives the answer.
Result in accurate friendly Bahasa Melayu.
Do not mix with Indonesian word.
DO NOT ask too much question about recipe, my secret recipe etc, my customer
didn't know that.
Give only 1 result.
Do not ask for any secret trade like secret recipe, secret formula etc.
"'' }
      ]

      http_response = client.chat(
        parameters: {
          model: current_client.business.business_subscription.model_plan,
          messages:,
          temperature: 0.9
        }
      )

      @result = http_response.dig('choices', 0, 'message', 'content')

      business.business_token_consumptions.create(
        kind: 'ai.marketing.generative.engagement'
      )
      ai_result = business.ai_results.create(
        kind: 'ai.marketing.generative.engagement',
        input_text: messages,
        output_text: @result&.strip || nil,
        api_response: http_response,
        user_id: current_client.id
      )

      ai_result.save
      redirect_to new_clients_dashboards_tool_marketings_engagement_path, success: 'Copywriting generated!'
    rescue StandardError
      redirect_to new_clients_dashboards_tool_marketings_engagement_path, success: 'Oh oh. Something went wrong.'
    end
  end
end
