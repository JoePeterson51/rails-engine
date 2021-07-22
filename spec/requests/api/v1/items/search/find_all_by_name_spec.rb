require 'rails_helper'

RSpec.describe 'find items by name' do
  it 'can find an item by a name search' do
    merchant1 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)
    item1 = FactoryBot.create(:item, name: "abc", merchant: merchant1)
    item2 = FactoryBot.create(:item, name: "abcabc", merchant: merchant1)
    item3 = FactoryBot.create(:item, name: "abcabcabc", merchant: merchant1)

    get "/api/v1/items/find_all?name=#{item1.name}"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)
    expect(items[:data][0][:id].to_i).to eq(item1.id)
    expect(items[:data][1][:id].to_i).to eq(item2.id)
    expect(items[:data][2][:id].to_i).to eq(item3.id)
  end

  it 'returns 200 status if no item found' do
    merchant1 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)

    get '/api/v1/items/find_all?name=aaaaa'

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
  end

  it 'returns 400 and error message if params are invalid' do
    merchant1 = FactoryBot.create(:merchant)
    create_list(:item, 20, merchant: merchant1)

    get '/api/v1/items/find_all?name='

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(item[:error]).to eq("Invalid Search")
  end
end