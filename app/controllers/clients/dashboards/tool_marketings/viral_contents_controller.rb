# frozen_string_literal: true

class Clients::Dashboards::ToolMarketings::ViralContentsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @histories = current_client.business.ai_results
                               .where(kind: 'ai.marketing.generative.viral_content_idea')
                               .where(created_at: 7.days.ago..Time.zone.now)
                               .order(created_at: :desc)
  end

  def new
    business = current_client.business
    limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.viral_content_idea')
    consumption_count = business.business_token_consumptions
                                .where(kind: 'ai.marketing.generative.viral_content_idea')
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
    @result = business.ai_results.where(kind: 'ai.marketing.generative.viral_content_idea').order(created_at: :desc).first
  end

  def create
    @result = nil

    # TODO: check if in quota
    business = current_client.business
    token_limit = business.business_token_limits.find_by(kind: 'ai.marketing.generative.viral_content_idea')

    if token_limit.limit_by == 'weekly'
      consumptions = business.business_token_consumptions
                             .where(kind: 'ai.marketing.generative.viral_content_idea')
                             .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                             .count

      if consumptions >= token_limit.limit
        return redirect_to new_clients_dashboards_tool_marketings_viral_content_path,
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
Result in accurate local Bahasa Melayu in Malaysia.
Do not mix with Indonesian word.
My company name is #{current_client.business.name}.
I'm a business owner and would like to make my business viral.
Give me ONLY ONE unique viral video content ideas for my business,
that has never been tried before. You can be as creative, such as
going viral with love couple fighting drama, food challenges, sad story,
Some other example:
      Behind-the-Scenes Kitchen Tour,
      How our company looks like back in the days,
      Chef's Cooking Tips and Tricks,
      Signature Dish Preparation Videos,
      Life as an employee,
      Customer Testimonials and Reviews,
      Food Tasting Challenges,
      Foodie Interviews with Regular Customers,
      Recipe Demos with a Restaurant Twist,
      Interactive Polls for Menu Decisions,
      \"Day in the Life\" of Restaurant Staff,
      Special Event Highlights (e.g., live music, themed nights),
      Food Art and Presentation Showcase,
      Chef vs. Food Challenges,
      Cooking Classes or Workshops,
      Food Pairing Suggestions,
      Local Food Sourcing and Sustainability Stories,
      Foodie Contests and Giveaways,
      Employee Spotlight Interviews,
      Creative Menu Teasers and Previews,
      Customer Success Stories,
      Timelapse Videos of Food Preparation,
      sentimental video, and more.
      Customer forgot their order, the shop already consumed the product and now
      the customer is coming to get the product.
      Mini dramas.
AVOID giving response about secret or unknown recipe, customer
don't want to know that.
Limit 30 words, ONLY gives the answer. Result in accurate friendly Bahasa Melayu.
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
        kind: 'ai.marketing.generative.viral_content_idea'
      )
      ai_result = business.ai_results.create(
        kind: 'ai.marketing.generative.viral_content_idea',
        input_text: messages,
        output_text: @result&.strip || nil,
        api_response: http_response,
        user_id: current_client.id
      )

      ai_result.save
      redirect_to new_clients_dashboards_tool_marketings_viral_content_path, success: 'Copywriting generated!'
    rescue StandardError
      redirect_to new_clients_dashboards_tool_marketings_viral_content_path, success: 'Oh oh. Something went wrong.'
    end
  end
end
