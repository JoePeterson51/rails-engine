require 'rails_helper'

RSpec.describe 'find items by name' do
  it 'can find an item by a name search' do
    merchant1 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)
    item1 = FactoryBot.create(:item, name: "aaaa", merchant: merchant1)

    get "/api/v1/items/find?name=#{item1.name}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to eq(item1.name)
  end

  it 'returns error if no item found' do
    merchant1 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)

    get '/api/v1/items/find?name=aaaaa'

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(item[:data]).to eq({})
  end
end