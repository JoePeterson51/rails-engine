require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'revenue search' do
    before :each do
      @merchant_1 = FactoryBot.create(:merchant, id: 1)
      @merchant_2 = FactoryBot.create(:merchant, id: 2)
      @merchant_3 = FactoryBot.create(:merchant, id: 3)

      @item_1 = FactoryBot.create(:item, id: 1, merchant: @merchant_1, unit_price: 1000)
      @item_2 = FactoryBot.create(:item, id: 2, merchant: @merchant_2, unit_price: 1200)
      @item_3 = FactoryBot.create(:item, id: 3, merchant: @merchant_2, unit_price: 5)
      @item_4 = FactoryBot.create(:item, id: 4, merchant: @merchant_1, unit_price: 10)
      @item_5 = FactoryBot.create(:item, id: 5, merchant: @merchant_3, unit_price: 10)
      @item_6 = FactoryBot.create(:item, id: 6, merchant: @merchant_3, unit_price: 10)

      @customer = FactoryBot.create(:customer)

      @invoice_1 = Invoice.create!(status: "shipped", customer: @customer, created_at: "2012-03-20 09:54:09")
      @invoice_2 = Invoice.create!(status: "packaged", customer: @customer)
      @invoice_3 = Invoice.create!(status: "packaged", customer: @customer)

      @transaction = Transaction.create!(result: "success", invoice: @invoice_1)
      @transaction_2 = Transaction.create!(result: "success", invoice: @invoice_2)

      @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1000, quantity: 1)
      @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: 1200, quantity: 1)
      @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_2, unit_price: 5, quantity: 1)
      @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_2, unit_price: 10, quantity: 1)
      @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_5, invoice: @invoice_2, unit_price: 10, quantity: 1)
      @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_6, invoice: @invoice_3, unit_price: 10, quantity: 1)
    end
    describe '#find_revenue_between_dates' do
      it 'can find the total revenue between a set of dates' do
        expect(Invoice.find_revenue_between_dates('2012-03-09', '2012-03-24')).to eq(2200.0)
      end
    end

    describe '#find_unshipped_potential_revenue' do
      it 'can find the top invoices with unshipped potential revenue' do
        expect(Invoice.find_unshipped_potential_revenue(1)[0].id).to eq(@invoice_2.id)
      end
    end
  end
end