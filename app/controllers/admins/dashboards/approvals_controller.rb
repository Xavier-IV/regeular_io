# frozen_string_literal: true

class Admins::Dashboards::ApprovalsController < ApplicationController
  include AdminLayout

  def approve
    business = Business.find(params[:business_id])
    return redirect_to(admins_dashboard_path, notice: 'Business not found.') if business.blank?

    latest_approval = business.business_approval_histories.unresolved.first
    latest_approval.update(resolved: true) if latest_approval.present?

    history = business.business_approval_histories.create(
      managed_by_id: current_admin.id,
      status: 'approved'
    )

    if history.persisted? && business.update(status: 'approved')
      redirect_to admins_dashboard_path, success: 'Business approved.'
    else
      redirect_to admins_dashboard_path, alert: business.errors.full_messages.join('. ')
    end
  end

  def reject
    business = Business.find(params[:business_id])
    return redirect_to(admins_dashboard_path, notice: 'Business not found.') if business.blank?

    if params[:system_remark].blank?
      return redirect_to(admins_dashboard_path,
                         alert: 'Remark cannot be empty when rejecting.')
    end

    latest_approval = business.business_approval_histories.unresolved.first
    latest_approval.update(resolved: true) if latest_approval.present?

    history = business.business_approval_histories.create(
      managed_by_id: current_admin.id,
      status: 'rejected',
      system_remark: params[:system_remark]
    )

    if history.persisted? && business.update(status: 'rejected')
      redirect_to admins_dashboard_path, success: 'Business rejected.'
    else
      redirect_to admins_dashboard_path, alert: business.errors.full_messages.join('. ')
    end
  end
end
