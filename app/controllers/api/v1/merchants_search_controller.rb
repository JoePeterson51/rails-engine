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
      self.create_render(merchant, MerchantRevenueSerializer)
    else
      render json: { error: "Merchant(s) Not Found", data: {} }, status: 400
    end
  end
end