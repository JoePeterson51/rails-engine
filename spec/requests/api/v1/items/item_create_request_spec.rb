require 'rails_helper'

RSpec.describe 'create item request' do
  it 'can create a item through a request' do
    merchant = FactoryBot.create(:merchant, id: 14)
    post '/api/v1/items', params: {
                                    "name": "value1",
                                    "description": "value2",
                                    "unit_price": 100.99,
                                    "merchant_id": 14
                                  }

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to eq("value1")
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to eq("value2")
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to eq(100.99)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to eq(14)
  end
end