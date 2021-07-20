require 'rails_helper'

RSpec.describe 'item show request' do
  it 'can return one item' do
    merchant1 = FactoryBot.create(:merchant)
    merchant2 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)
    create_list(:item, 20, merchant: merchant2)

    get "/api/v1/items/#{Item.first[:id]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:id]).to eq(Item.first[:id].to_s)
  end
end