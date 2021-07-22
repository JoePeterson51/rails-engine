class Api::V1::MerchantsSearchController < ApplicationController
  include SearchRenderHelper

  def find
    if params[:name].present?
      merchant = Merchant.find_one_by_name(params["name"])
      self.create_render(merchant, MerchantSerializer)
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end

  def find_all
    if params[:name].present?
      merchant = Merchant.find_all_by_name(params["name"])
      self.create_render(merchant, MerchantSerializer)
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end

  def most_items
    if params["quantity"].present? && params["quantity"].to_i != 0
      merchant = Merchant.most_items_sold(params["quantity"].to_i)
      self.create_render(merchant, MerchantItemCountSerializer)
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end
end