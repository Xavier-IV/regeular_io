class Clients::Dashboards::ToolMoodboards::InteriorDesignsController < ApplicationController
  include Dashboard::LayoutDetail
  include Dashboard::Auth
  include Dashboard::Verified

  def index
    @histories = current_client.business.ai_results
                               .where(kind: 'ai.moodboard.generative.interior_design')
                               .where(created_at: 7.days.ago..Time.zone.now)
                               .order(created_at: :desc)
  end

  def new
    business = current_client.business
    limit = business.business_token_limits.find_or_create_by(kind: 'ai.moodboard.generative.interior_design')
    if limit.limit.blank?
      limit.limit = business.business_subscription.plan == 'SME Business' ? 5 : 3
      limit.limit_by = 'week'
      limit.save
    end
    consumption_count = business.business_token_consumptions
                                .where(kind: 'ai.moodboard.generative.interior_design')
                                .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                                .count

    @percentage = consumption_count.positive? ? ((limit.limit.to_f - consumption_count.to_f) / limit.limit.to_f) * 100 : 100.0
    @balance = "#{[(limit.limit - consumption_count), 0].max}/#{limit.limit}"
    @balance_left = limit.limit - consumption_count
    @result = business.ai_results.where(kind: 'ai.moodboard.generative.interior_design').order(created_at: :desc).first

  end

  def create
    @result = nil

    business = current_client.business
    token_limit = business.business_token_limits.find_by(kind: 'ai.moodboard.generative.interior_design')

    if token_limit.limit_by == 'weekly'
      consumptions = business.business_token_consumptions
                             .where(kind: 'ai.moodboard.generative.interior_design')
                             .where(created_at: Date.current.beginning_of_week..Date.current.end_of_week.end_of_day)
                             .count

      if consumptions >= token_limit.limit
        return redirect_to new_clients_dashboards_tool_moodboards_interior_design_path,
                           alert: 'You\'ve reached the quota for this week.'
      end
    end

    begin
      client = OpenAI::Client.new

      parameters = {
        model: 'dall-e-3',
        prompt: ''"
Provide an interior fancy design for my business named #{current_client.business.name}.
Visualise that it is bustling with many customers.
The design is beautiful, clean and rememberable.
Include greeneries where needed but minimal.
"'',
        size: '1024x1024',
        quality: 'standard',
        n: 1
      }
      http_response = client.images.generate(
        parameters:
      )
      image_url = http_response.dig('data', 0, 'url')

      business.business_token_consumptions.create(
        kind: 'ai.moodboard.generative.interior_design'
      )
      ai_result = business.ai_results.create(
        kind: 'ai.moodboard.generative.interior_design',
        input_text: parameters.to_json,
        output_text: @result || nil,
        api_response: http_response,
        user_id: current_client.id
      )

      image_downloaded = Down.download(image_url)
      ai_result.image.attach(io: image_downloaded, filename: 'result.png')
      ai_result.save

      @result = ai_result
      redirect_to new_clients_dashboards_tool_moodboards_interior_design_path, success: 'Image generated!'
    rescue StandardError => e
      Rails.logger.warn "[OpenAI:Moodboards:Banners] Received error: #{e}"
      redirect_to new_clients_dashboards_tool_moodboards_interior_design_path, success: 'Oh oh. Something went wrong.'
    end
  end
end
