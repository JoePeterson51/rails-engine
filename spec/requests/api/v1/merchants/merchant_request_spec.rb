require 'rails_helper'

RSpec.describe 'merchant show request' do
  it 'can return one merchant' do
    create_list(:merchant, 40)

    get "/api/v1/merchants/#{Merchant.first[:id]}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq(Merchant.first[:id].to_s)
  end
end