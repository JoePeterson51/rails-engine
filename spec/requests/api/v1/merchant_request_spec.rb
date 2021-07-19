require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends merchants in pages of 20 by default' do
    create_list(:merchant, 40)
    get '/api/v1/merchants'
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can get page 2 of merchants' do
    create_list(:merchant, 40)

    get '/api/v1/merchants?page=1'

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant1 = Merchant.first[:id]
    merchant21 = Merchant.last[:id]

    expect(merchants[:data].first[:id].to_i).to eq(merchant1)
    expect(merchants[:data].first[:id].to_i).to_not eq(merchant21)

    get '/api/v1/merchants?page=2'
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].last[:id].to_i).to eq(merchant21)
    expect(merchants[:data].first[:id].to_i).to_not eq(merchant1)
  end

  it 'can send more merchants with per_page param' do
    create_list(:merchant, 40)
    get '/api/v1/merchants?per_page=30'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(30)
  end

  it 'can return one merchant' do
    create_list(:merchant, 40)
    get "/api/v1/merchants/#{Merchant.first[:id]}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq(Merchant.first[:id].to_s)
  end

  it 'can return all the merchants items' do
    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, merchant: merchant1)
    get "/api/v1/merchants/#{merchant1.id}/items"
    item = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    expect(item[:data].first[:id].to_i).to eq(item1.id)
  end
end