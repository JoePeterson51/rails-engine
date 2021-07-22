require 'rails_helper'

RSpec.describe 'update item request' do
  it 'can update an item' do
    merchant = FactoryBot.create(:merchant, id: 14)
    post '/api/v1/items', params: {
                                    "name": "value1",
                                    "description": "value2",
                                    "unit_price": 100.99,
                                    "merchant_id": 14
                                  }
    patch "/api/v1/items/#{Item.first.id}", params: {
                                    "name": "Dog toy",
                                    "description": "A great toy for dogs",
                                    "unit_price": 12.99,
                                    "merchant_id": 14
                                  }

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to eq("Dog toy")
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to eq("A great toy for dogs")
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to eq(12.99)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to eq(14)
  end

  it 'returns error if unit price is not an integer' do
    merchant = FactoryBot.create(:merchant, id: 14)
    post '/api/v1/items', params: {
                                    "name": "value1",
                                    "description": "value2",
                                    "unit_price": 100.99,
                                    "merchant_id": 14
                                  }
    patch "/api/v1/items/#{Item.first.id}", params: {
                                    "name": "Dog toy",
                                    "description": "A great toy for dogs",
                                    "unit_price": "blah",
                                    "merchant_id": 14
                                  }

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
  end
end