equire 'rails_helper'

RSpec.describe '#unshipped_potential_revenue' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)

    @item_1 = FactoryBot.create(:item, id: 1, merchant: @merchant_1, unit_price: 1000)
    @item_2 = FactoryBot.create(:item, id: 2, merchant: @merchant_1, unit_price: 1200)
    @item_3 = FactoryBot.create(:item, id: 3, merchant: @merchant_1, unit_price: 5)
    @item_4 = FactoryBot.create(:item, id: 4, merchant: @merchant_1, unit_price: 10)

    @customer = FactoryBot.create(:customer)

    @invoice_1 = Invoice.create!(status: "shipped", customer: @customer)
    @invoice_2 = Invoice.create!(status: "packaged", customer: @customer)

    @transaction = Transaction.create!(result: "success", invoice: @invoice_1)
    @transaction_2 = Transaction.create!(result: "success", invoice: @invoice_2)

    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1000, quantity: 1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: 1200, quantity: 1)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_2, unit_price: 5, quantity: 1)
    @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_2, unit_price: 10, quantity: 1)
  end

  it 'returns the potential revenue of all items not shipped' do
    get '/api/v1/revenue/unshipped'

    revenue = JSON.parse(response.body, symbolize_names: true)

  end
end