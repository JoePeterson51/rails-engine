class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params["id"])
    items = merchant.items
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end
end