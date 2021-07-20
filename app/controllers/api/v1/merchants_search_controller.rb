class Api::V1::MerchantsSearchController < ApplicationController
  include SearchRenderHelper

  def find_by_name
    merchant = Merchant.find_one_by_name(params["name"])
    self.create_render(merchant, MerchantSerializer)
  end

  def search_all_by_name
    merchant = Merchant.find_all_by_name(params["name"])
    self.create_render(merchant, MerchantSerializer)
  end
end