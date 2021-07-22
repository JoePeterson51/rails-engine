require 'rails_helper'

RSpec.describe 'find items by name' do
  it 'can find an item by a name search' do
    create_list(:merchant, 40)
    merchant1 = FactoryBot.create(:merchant, name: "aaaa")

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
  end

  it 'returns status 200 with empty object for no search found' do
    create_list(:merchant, 40)

    get "/api/v1/merchants/find?name=aaaa"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(merchant[:data]).to eq({})
  end

  it 'returns status 400 and error message if search invalid' do
    create_list(:merchant, 40)

    get "/api/v1/merchants/find?name="

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(merchant[:error]).to eq("Invalid Search")
  end
end