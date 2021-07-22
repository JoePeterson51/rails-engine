require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe '#find_one_by_name' do
    it 'finds one merchant by name' do
      create_list(:merchant, 40)

      expect(Merchant.find_one_by_name("#{Merchant.first.name}")).to eq(Merchant.first)
    end
  end

  describe '#find_all_by_name' do
    it 'finds all merchants that contain name fragment' do
      create_list(:merchant, 40)
      merchant1 = FactoryBot.create(:merchant, name: "abc")
      merchant2 = FactoryBot.create(:merchant, name: "abcabc")
      merchant3 = FactoryBot.create(:merchant, name: "abcabcabc")

      expect(Merchant.find_all_by_name('abc').count).to eq(3)
      expect(Merchant.find_all_by_name('abc')[0]).to eq(merchant1)
      expect(Merchant.find_all_by_name('abc')[1]).to eq(merchant2)
      expect(Merchant.find_all_by_name('abc')[2]).to eq(merchant3)
    end
  end

  describe 'revenue/items sold search' do
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

      @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1000, quantity: 3)
      @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: 1200, quantity: 10)
      @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_1, unit_price: 500, quantity: 1)
    end

    describe '#find_top_revenue' do
      it 'finds specific number of merchants with the top revenue' do
        expect(Merchant.find_top_revenue(2)[0]).to eq(@merchant_2)
        expect(Merchant.find_top_revenue(2)[1]).to eq(@merchant_1)
      end
    end

    describe '#most_items_sold' do
      it 'finds specific number of merchants with the top items sold' do
        expect(Merchant.most_items_sold(2)[0]).to eq(@merchant_2)
        expect(Merchant.most_items_sold(2)[1]).to eq(@merchant_1)
      end
    end

    describe '#merchants_total_revenue' do
      it 'returns one merchants total revenue' do
        expect(@merchant_1.merchants_total_revenue).to eq(3000)
      end
    end
  end
end