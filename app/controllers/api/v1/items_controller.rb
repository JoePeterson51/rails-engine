class Api::V1::ItemsController < ApplicationController
  def index
    per_page = params.fetch(:per_page, 20).to_i
    if params["page"].to_i >= 1
      page = params["page"].to_i - 1
    else
      page = params.fetch(:page, 0).to_i
    end
    items = Item.offset(page * per_page).limit(per_page)
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end

  def show
    item = Item.find(params["id"].to_i)
    render json: ItemSerializer.new(item).serializable_hash.to_json
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item).serializable_hash.to_json,
        status: 201
    else
      render json: {status: 'ERROR', message: 'Item not saved',
        data:item.errors}, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end