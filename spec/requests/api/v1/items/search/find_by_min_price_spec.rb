require 'rails_helper'

RSpec.describe 'find item by min price' do
  it 'can find an item by a minimum price search' do
    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: 'aaa', unit_price: 5.0, merchant: merchant1)
    item2 = FactoryBot.create(:item, name: 'bbb', unit_price: 7.5, merchant: merchant1)
    item3 = FactoryBot.create(:item, name: 'ccc', unit_price: 10.0, merchant: merchant1)

    get "/api/v1/items/find?min_price=6"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data][:attributes][:name]).to eq(item2.name)
  end
end