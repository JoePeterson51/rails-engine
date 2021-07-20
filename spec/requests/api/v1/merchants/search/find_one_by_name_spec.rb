require 'rails_helper'

RSpec.describe 'find items by name' do
  it 'can find an item by a name search' do
    create_list(:merchant, 40)
    merchant1 = FactoryBot.create(:merchant, name: "aaaa")

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
  end
end