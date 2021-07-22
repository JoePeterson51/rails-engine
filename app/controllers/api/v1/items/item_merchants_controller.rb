class Api::V1::Items::ItemMerchantsController < ApplicationController
  def index
    item = Item.find(params["id"])
    merchant = Merchant.find(item.merchant_id)
    render json: MerchantSerializer.new(merchant).serializable_hash.to_json
  end
end