require 'rails_helper'

RSpec.describe 'items index request' do
  before :each do
    merchant1 = FactoryBot.create(:merchant)
    merchant2 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)
    create_list(:item, 20, merchant: merchant2)
  end

  it 'can request all items' do
    get '/api/v1/items'
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(20)
    expect(Item.all.count).to eq(40)

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

  it 'can get page 2 of items' do
    get '/api/v1/items?page=1'

    items = JSON.parse(response.body, symbolize_names: true)
    item1 = Item.first[:id]
    item2 = Item.last[:id]

    expect(items[:data].first[:id].to_i).to eq(item1)
    expect(items[:data].first[:id].to_i).to_not eq(item2)

    get '/api/v1/items?page=2'
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].last[:id].to_i).to eq(item2)
    expect(items[:data].first[:id].to_i).to_not eq(item1)
  end

  it 'can send more merchants with per_page param' do
    get '/api/v1/items?per_page=30'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(30)
  end
end