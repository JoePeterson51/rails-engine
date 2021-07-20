class Api::V1::ItemsSearchController < ApplicationController
  include SearchRenderHelper

  def find_by_name
    item = Item.find_one_by_name(params["name"])
    self.create_render(item, ItemSerializer)
  end

  def search_all_by_name
    item = Item.find_all_by_name(params["name"])
    self.create_render(item, ItemSerializer)
  end
end