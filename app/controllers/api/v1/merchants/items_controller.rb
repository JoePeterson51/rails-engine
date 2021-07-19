class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params["merchant_id"])
    items = merchant.items
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end
end