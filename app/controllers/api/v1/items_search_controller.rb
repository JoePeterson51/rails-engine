class Api::V1::ItemsSearchController < ApplicationController
  include SearchRenderHelper
  include ItemValidationHelper

  def find
    if self.valid_name?(params)
      item = Item.find_one_by_name(params["name"])
    elsif self.valid_price_range?(params)
      item = Item.find_by_price_range(params["min_price"], params["max_price"])
    elsif self.valid_min_price?(params)
      item = Item.find_by_min_price(params["min_price"])
    elsif self.valid_max_price?(params)
      item = Item.find_by_max_price(params["max_price"])
    else
      return render json: { error: "Invalid Search", data: {} }, status: 400
    end
    self.create_render(item, ItemSerializer)
  end

  def find_all
    if params["name"].present?
      item = Item.find_all_by_name(params["name"])
      self.create_render(item, ItemSerializer)
    else
      render json: { error: "Invalid Search", data: {} }, status: 400
    end
  end
end