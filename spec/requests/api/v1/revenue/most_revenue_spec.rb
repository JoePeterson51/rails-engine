require 'rails_helper'

RSpec.describe 'most revenue' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)
    @merchant_3 = FactoryBot.create(:merchant)

    @item_1 = FactoryBot.create(:item, merchant: @merchant_1, unit_price: 1000)
    @item_2 = FactoryBot.create(:item, merchant: @merchant_2, unit_price: 1200)
    @item_3 = FactoryBot.create(:item, merchant: @merchant_3, unit_price: 500)

    @customer = FactoryBot.create(:customer)

    @invoice_1 = Invoice.create!(status: "shipped", customer: @customer)

    @transaction = Transaction.create!(result: "success", invoice: @invoice_1)

    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1000, quantity: 1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: 1200, quantity: 1)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_1, unit_price: 500, quantity: 1)
  end

  it 'can retrive the number of merchants specifed with the largest revenue' do
    get "/api/v1/revenue/merchants?quantity=2"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data][0][:id].to_i).to eq(@merchant_2.id)
    expect(merchants[:data][1][:id].to_i).to eq(@merchant_1.id)
  end

  it 'will send an error if params arent present' do
    get "/api/v1/revenue/merchants?quantity="

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
  end

  it 'will send an error if params arent numbers' do
    get "/api/v1/revenue/merchants?quantity=blahblahblah"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
  end
end