require 'rails_helper'

RSpec.describe '#top_items_revenue' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)

    @item_1 = FactoryBot.create(:item, id: 1, merchant: @merchant_1, unit_price: 1000)
    @item_2 = FactoryBot.create(:item, id: 2, merchant: @merchant_1, unit_price: 1200)
    @item_3 = FactoryBot.create(:item, id: 3, merchant: @merchant_1, unit_price: 5)
    @item_4 = FactoryBot.create(:item, id: 4, merchant: @merchant_1, unit_price: 10)
    @item_5 = FactoryBot.create(:item, id: 5, merchant: @merchant_1, unit_price: 15)
    @item_6 = FactoryBot.create(:item, id: 6, merchant: @merchant_1, unit_price: 20)
    @item_7 = FactoryBot.create(:item, id: 7, merchant: @merchant_1, unit_price: 25)
    @item_8 = FactoryBot.create(:item, id: 8, merchant: @merchant_1, unit_price: 30)
    @item_9 = FactoryBot.create(:item, id: 9, merchant: @merchant_1, unit_price: 35)
    @item_10 = FactoryBot.create(:item, id: 10, merchant: @merchant_1, unit_price: 40)

    @customer = FactoryBot.create(:customer)

    @invoice_1 = Invoice.create!(status: "shipped", customer: @customer)

    @transaction = Transaction.create!(result: "success", invoice: @invoice_1)

    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1000, quantity: 1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: 1200, quantity: 1)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_1, unit_price: 5, quantity: 1)
    @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_1, unit_price: 10, quantity: 1)
    @invoice_item_5 = FactoryBot.create(:invoice_item, item: @item_5, invoice: @invoice_1, unit_price: 15, quantity: 1)
    @invoice_item_6 = FactoryBot.create(:invoice_item, item: @item_6, invoice: @invoice_1, unit_price: 20, quantity: 1)
    @invoice_item_7 = FactoryBot.create(:invoice_item, item: @item_7, invoice: @invoice_1, unit_price: 25, quantity: 1)
    @invoice_item_8 = FactoryBot.create(:invoice_item, item: @item_8, invoice: @invoice_1, unit_price: 30, quantity: 1)
    @invoice_item_9 = FactoryBot.create(:invoice_item, item: @item_9, invoice: @invoice_1, unit_price: 35, quantity: 1)
    @invoice_item_10 = FactoryBot.create(:invoice_item, item: @item_10, invoice: @invoice_1, unit_price: 40, quantity: 1)
  end

  it 'returns the amount of items specified with top revenue' do
    get '/api/v1/revenue/items?quantity=2'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data][0][:id].to_i).to eq(@item_2.id)
    expect(items[:data][1][:id].to_i).to eq(@item_1.id)
  end

  it 'returns response status 400 for invalid search' do
    get '/api/v1/revenue/items?quantity=fdfdf'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
  end

  it 'returns the top 10 items if no params are provided' do
    get '/api/v1/revenue/items'

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(10)
    expect(items[:data][0][:id].to_i).to eq(@item_2.id)
    expect(items[:data][9][:id].to_i).to eq(@item_3.id)
  end
end