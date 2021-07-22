class Api::V1::RevenueController < ApplicationController
  include SearchRenderHelper

  def most_revenue
    if params["quantity"].present? && params["quantity"].to_i != 0
      merchant = Merchant.find_top_revenue(params["quantity"].to_i)
      self.create_render(merchant, MerchantNameRevenueSerializer)
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end

  def merchant_revenue
    merchant = Merchant.find(params["id"].to_i)
    total_revenue = merchant.merchants_total_revenue
    render json: {data: {id: merchant.id.to_s, type: 'merchant_revenue', attributes: {revenue: total_revenue}}}
  end

  def date_revenue
    if params["start"].present? && params["end"].present?
      revenue = InvoiceItem.find_revenue_between_dates(params["start"], params["end"])
      render json: {data: {id: {}, attributes: {revenue: revenue}}}
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end

  def top_items_revenue
    quantity = params[:quantity] || 10
    if quantity.present? && quantity.to_i != 0 && !quantity.to_i.negative?
      items = Item.find_top_items_revenue(quantity.to_i)
      self.create_render(items, ItemRevenueSerializer)
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end
end