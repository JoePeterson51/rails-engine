class Api::V1::MerchantsSearchController < ApplicationController
  include SearchRenderHelper

  def find
    if params[:name].present?
      merchant = Merchant.find_one_by_name(params["name"])
      self.create_render(merchant, MerchantSerializer)
    else
      render json: { data: {} }, status: 400
    end
  end

  def find_all
    if params[:name].present?
      merchant = Merchant.find_all_by_name(params["name"])
      self.create_render(merchant, MerchantSerializer)
    else
      render json: { data: {} }, status: 400
    end
  end

  def most_revenue
    if params["quantity"].present? && params["quantity"].to_i != 0
      merchant = Merchant.find_top_revenue(params["quantity"].to_i)
      self.create_render(merchant, MerchantNameRevenueSerializer)
    else
      render json: { error: "Merchant(s) Not Found", data: {} }, status: 400
    end
  end

  def most_items
    if params["quantity"].present? && params["quantity"].to_i != 0
      merchant = Merchant.most_items_sold(params["quantity"].to_i)
      self.create_render(merchant, MerchantItemCountSerializer)
    else
      render json: { error: "Merchant(s) Not Found", data: {} }, status: 400
    end
  end

  def merchant_revenue
    merchant = Merchant.find(params["id"].to_i)
    total_revenue = merchant.merchants_total_revenue
    render json: {data: {id: merchant.id.to_s, type: 'merchant_revenue', attributes: {revenue: total_revenue}}}
  end
end