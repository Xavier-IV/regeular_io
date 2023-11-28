# frozen_string_literal: true

class PwaSubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    customer = Customer.first
    push_subscription = Customer::PushSubscription.new(
      auth: subscription_params[:keys][:auth],
      p256dh: subscription_params[:keys][:p256dh],
      endpoint: subscription_params[:endpoint],
      user_id: customer.id
    )

    if push_subscription.save
      PushNotificationService.send_notification(
        'Notification Enabled',
        'You have enabled notification for Regülar',
        push_subscription
      )
      render json: { status: 'success', message: 'Subscription saved.' }, status: :ok
    else
      render json: { status: 'error', message: 'Failed to save subscription.' }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:endpoint, keys: %i[p256dh auth])
  end
end
