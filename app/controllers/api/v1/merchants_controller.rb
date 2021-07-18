class Api::V1::MerchantsController < ApplicationController
  MERCHANTS_PER_PAGE = 20

  def index
    page = params.fetch(:page, 0).to_i
    render json: Merchant.offset(page * MERCHANTS_PER_PAGE).limit(MERCHANTS_PER_PAGE)
  end
end