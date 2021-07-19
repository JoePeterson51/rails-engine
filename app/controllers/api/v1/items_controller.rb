class Api::V1::ItemsController < ApplicationController
  def index
    per_page = params.fetch(:per_page, 20).to_i
    if params["page"].to_i >= 1
      page = params["page"].to_i - 1
    else
      page = params.fetch(:page, 0).to_i
    end
    @items = Item.offset(page * per_page).limit(per_page)
    render json: ItemSerializer.new(@items).serializable_hash.to_json
  end
end