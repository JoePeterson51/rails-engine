require 'rails_helper'

RSpec.describe 'destroy item request' do
  it 'can destroy an item' do
    merchant = FactoryBot.create(:merchant, id: 14)
    post '/api/v1/items', params: {
                                    "name": "value1",
                                    "description": "value2",
                                    "unit_price": 100.99,
                                    "merchant_id": 14
                                  }
    expect(Item.first.name).to eq("value1")

    delete "/api/v1/items/#{Item.first.id}"

    expect(Item.first).to eq(nil)
  end
end