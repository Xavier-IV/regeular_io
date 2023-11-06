# frozen_string_literal: true

class Dashboards::ProductsController < ApplicationController
  include DashboardLayout

  def index
    @products = current_client.business.products
  end

  def new
    @product = current_client.business.products.build
  end

  def create
    @product = current_client.business.products.create(product_params)
    @product.image.attach(asset_params[:image]) if asset_params[:image]

    if @product.persisted? && @product.name.present?
      redirect_to dashboards_products_path, notice: 'Record updated.'
    elsif @product.persisted? && @product.name.blank?
      redirect_to edit_dashboards_product_path(@product), notice: 'Record updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Business::Product.find(query_params[:id])
  end

  def edit
    @product = Business::Product.find(query_params[:id])
  end

  def update
    @product = Business::Product.find(query_params[:id])

    @product.update(product_params)
    @product.image.attach(asset_params[:image]) if asset_params[:image]

    if @product.persisted?
      redirect_to dashboards_product_path(@product), notice: 'Record updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def query_params
    params.permit(:id)
  end

  def product_params
    params.require(:business_product).permit(:name, :price)
  end

  def asset_params
    params.require(:business_product).permit(:image)
  end
end
