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

  it 'can return the revenue between certain dates' do
    get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'
  end
end