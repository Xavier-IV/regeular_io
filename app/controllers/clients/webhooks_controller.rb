# frozen_string_literal: true

class Clients::WebhooksController < ApplicationController
  protect_from_forgery except: :stripe

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      key = 'whsec_3b34facffd075873db895ba1a96ae5b63caf06ae101ac3ea9c23c24802546171'
      event = Stripe::Webhook.construct_event(payload, sig_header, key)
    rescue JSON::ParserError
      render json: { error: 'Invalid payload' }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError
      render json: { error: 'Invalid signature' }, status: :bad_request
      return
    end

    render json: { message: 'Success' }, status: :ok

    # Handle the event
    case event.type
    when 'invoice.payment_succeeded'
      payment_intent = event.data.object
      subscription_id = payment_intent['subscription']

      if payment_intent['customer_email'].present?
        client = Client.find_or_initialize_by(email: payment_intent['customer_email'])

        if client.new_record?
          client.password = Devise.friendly_token[0, 20]
          client.password_confirmation = client.password
          client.skip_confirmation!
          client.invite!

          business = Business.create
          client.business = business
          client.save
        end

        if client.business.present?
          Rails.logger.debug 'Renewing testing....>>>>'
          subscription = Stripe::Subscription.retrieve(subscription_id)
          product_name = fetch_product_name_from_subscription(subscription)
          start_date = Time.zone.at(subscription['current_period_start']).to_date
          end_date = Time.zone.at(subscription['current_period_end']).to_date
          status = subscription['status']

          subs = Business::Subscription.find_or_create_by(
            business_id: client.business.id
          )
          subs.update(
            start_date:,
            end_date:,
            status:,
            stripe_subscription_id: subscription_id,
            plan: product_name
          )
        end
      end
      Rails.logger.debug 'Running.....'
    when 'customer.subscription.updated'
      payment_intent = event.data.object
      subscription_id = payment_intent['subscription']

      if payment_intent['customer_email'].present?
        client = Client.find_or_initialize_by(email: payment_intent['customer_email'])

        if client.business.present?
          Rails.logger.debug 'Renewing testing....>>>>'
          subscription = Stripe::Subscription.retrieve(subscription_id)
          product_name = fetch_product_name_from_subscription(subscription)
          start_date = Time.zone.at(subscription['current_period_start']).to_date
          end_date = Time.zone.at(subscription['current_period_end']).to_date
          status = subscription['status']

          subs = Business::Subscription.find_or_create_by(
            business_id: client.business.id
          )
          subs.update(
            start_date:,
            end_date:,
            status:,
            stripe_subscription_id: subscription_id,
            plan: product_name
          )
        end
      end
    when 'customer.subscription.deleted'
      payment_intent = event.data.object
      subscription_id = payment_intent['subscription']

      if payment_intent['customer_email'].present?
        client = Client.find_or_initialize_by(email: payment_intent['customer_email'])

        if client.business.present?
          Rails.logger.debug 'Renewing testing....>>>>'
          subscription = Stripe::Subscription.retrieve(subscription_id)
          product_name = fetch_product_name_from_subscription(subscription)
          start_date = Time.zone.at(subscription['current_period_start']).to_date
          end_date = Time.zone.at(subscription['current_period_end']).to_date
          status = subscription['status']

          subs = Business::Subscription.find_or_create_by(
            business_id: client.business.id
          )
          subs.update(
            start_date:,
            end_date:,
            status:,
            stripe_subscription_id: subscription_id,
            plan: product_name
          )
        end
      end
    else
      Rails.logger.warn "Unhandled event type: #{event.type}"
    end
  end

  private

  def fetch_product_name_from_subscription(subscription)
    # Assuming each subscription has one or more items, and each item is associated with a product
    item = subscription.items.data.first
    plan = Stripe::Plan.retrieve(item.plan.id)
    product = Stripe::Product.retrieve(plan.product)
    product.name
  end
end
