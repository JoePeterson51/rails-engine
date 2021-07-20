class Api::V1::Items::MerchantController < ApplicationController
  def index
    item = Item.find(params["item_id"].to_i)
    merchant = Merchant.find(item.merchant_id)
    render json: MerchantSerializer.new(merchant).serializable_hash.to_json
  end
end