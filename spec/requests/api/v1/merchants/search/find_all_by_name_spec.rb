require 'rails_helper'

RSpec.describe 'find items by name' do
  it 'can find an item by a name search' do
    create_list(:merchant, 40)
    merchant1 = FactoryBot.create(:merchant, name: "abc")
    merchant2 = FactoryBot.create(:merchant, name: "abcabc")
    merchant3 = FactoryBot.create(:merchant, name: "abcabcabc")

    get "/api/v1/merchants/find_all?name=#{merchant1.name}"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data][0][:id].to_i).to eq(merchant1.id)
    expect(merchants[:data][1][:id].to_i).to eq(merchant2.id)
    expect(merchants[:data][2][:id].to_i).to eq(merchant3.id)
  end

  it 'returns status 200 for no search found' do
    create_list(:merchant, 40)

    get "/api/v1/merchants/find_all?name=aaaa"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
  end

  it 'returns status 400 and error message if search invalid' do
    create_list(:merchant, 40)

    get "/api/v1/merchants/find_all?name="

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(merchant[:error]).to eq("Invalid Search")
  end
end