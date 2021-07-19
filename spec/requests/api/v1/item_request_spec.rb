require 'rails_helper'

RSpec.describe 'items request' do
  it 'can request all items' do
    merchant1 = FactoryBot.create(:merchant)
    merchant2 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)
    create_list(:item, 20, merchant: merchant2)
    get '/api/v1/items'
    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
end