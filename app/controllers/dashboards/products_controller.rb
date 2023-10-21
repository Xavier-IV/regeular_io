# frozen_string_literal: true

class Dashboards::ProductsController < ApplicationController
  include DashboardLayout

  def index
    @products = current_user.business.products
  end

  def new
    @product = current_user.business.products.build
  end

  def create
    @product = current_user.business.products.create(product_params)
    @product.image.attach(params[:business_product][:image]) if params[:business_product][:image]

    if @product.persisted? && @product.name.present?
      redirect_to dashboards_products_path, notice: 'Record updated.'
    elsif @product.persisted? && @product.name.blank?
      redirect_to edit_dashboards_product_path(@product), notice: 'Record updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Business::Product.find(params[:id])
  end

  def edit
    @product = Business::Product.find(params[:id])
  end

  def update
    @product = Business::Product.find(params[:id])

    @product.update(product_params)
    @product.image.attach(params[:business_product][:image]) if params[:business_product][:image]

    Rails.logger.debug params

    if @product.persisted?
      redirect_to dashboards_product_path(@product), notice: 'Record updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:business_product).permit(:name, :price)
  end
end
