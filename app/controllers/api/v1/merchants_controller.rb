class Api::V1::MerchantsController < ApplicationController

  def index
    per_page = params.fetch(:per_page, 20).to_i
    page = params.fetch(:page, 0).to_i
    @merchants = Merchant.offset(page * per_page).limit(per_page)
    render json: MerchantSerializer.new(@merchants).serializable_hash.to_json
  end
end