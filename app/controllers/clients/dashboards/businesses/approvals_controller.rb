# frozen_string_literal: true

class Clients::Dashboards::Businesses::ApprovalsController < ApplicationController
  include Dashboard::Layout
  include Dashboard::Auth

  def create
    business = current_client.business

    return redirect_to clients_dashboards_path if business.status != 'new' && business.status != 'rejected'

    unresolved = business.business_approval_histories.unresolved.first

    if business.status == 'rejected' && unresolved.present? && unresolved.status == 'rejected'
      business.update(status: 'new')
      unresolved.update(resolved: true)

      return redirect_to clients_dashboards_path
    end

    word_count = params[:client_remark].length
    return redirect_to(dashboards_path, alert: 'Need minimum of 50 characters') if word_count < 50

    business.status = 'pending_review'
    business.save

    approval_histories = business.business_approval_histories.create(
      requested_by_id: current_client.id,
      status: business.status,
      client_remark: params[:client_remark]
    )

    if approval_histories.persisted?
      redirect_to clients_dashboards_path, success: 'We will review your application.'
    else
      redirect_to clients_dashboards_path, alert: approval_histories.errors.full_messages.join('. ')
    end
  end

  def update
    business = current_client.business
    latest_approval = business.business_approval_histories.unresolved.first

    unless latest_approval.status == 'approved' && latest_approval.resolved == false && params[:confirmed] == 'true'
      return
    end

    latest_approval.update(resolved: true)
    redirect_to clients_dashboards_path
  end
end
