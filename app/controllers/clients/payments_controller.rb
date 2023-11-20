# frozen_string_literal: true

class Clients::PaymentsController < ApplicationController
  def new; end

  def create
    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })

    Stripe::Charge.create({
                            customer: customer.id,
                            amount: 1,
                            description: 'Description of your product',
                            currency: 'myr'
                          })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
