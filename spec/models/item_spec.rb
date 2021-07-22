require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price}
  end

  describe '#find_one_by_name' do
    it 'can find one item by name' do
      merchant1 = FactoryBot.create(:merchant)
      create_list(:item, 20, merchant: merchant1)

      expect(Item.find_one_by_name("#{Item.first.name}")).to eq(Item.first)
    end
  end

  describe '#find_all_by_name' do
    it 'can find all items that match name fragment' do
      merchant1 = FactoryBot.create(:merchant)
      create_list(:item, 20, merchant: merchant1)
      item1 = FactoryBot.create(:item, name: "abc", merchant: merchant1)
      item2 = FactoryBot.create(:item, name: "abcabc", merchant: merchant1)
      item3 = FactoryBot.create(:item, name: "abcabcabc", merchant: merchant1)


      expect(Item.find_all_by_name("abc").count).to eq(3)
      expect(Item.find_all_by_name("abc")[0]).to eq(item1)
      expect(Item.find_all_by_name("abc")[1]).to eq(item2)
      expect(Item.find_all_by_name("abc")[2]).to eq(item3)
    end
  end

  describe '#find_by_price_range' do
    it 'can find the items in a price range' do
      merchant1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, name: 'aaa', unit_price: 5.0, merchant: merchant1)
      item2 = FactoryBot.create(:item, name: 'bbb', unit_price: 7.5, merchant: merchant1)
      item3 = FactoryBot.create(:item, name: 'ccc', unit_price: 10.0, merchant: merchant1)

      expect(Item.find_by_price_range('6', '8')).to eq(item2)
    end
  end

  describe '#find_by_min_price' do
    it 'finds the items by a minimum price and returns one sorted alphabetically' do
      merchant1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, name: 'aaa', unit_price: 5.0, merchant: merchant1)
      item2 = FactoryBot.create(:item, name: 'bbb', unit_price: 7.5, merchant: merchant1)
      item3 = FactoryBot.create(:item, name: 'ccc', unit_price: 10.0, merchant: merchant1)

      expect(Item.find_by_min_price('6')).to eq(item2)
    end
  end

  describe '#find_by_max_price' do
    it 'finds the items by a max price and returns one sorted alphabetically' do
      merchant1 = FactoryBot.create(:merchant)
      item1 = FactoryBot.create(:item, name: 'aaa', unit_price: 5.0, merchant: merchant1)
      item2 = FactoryBot.create(:item, name: 'bbb', unit_price: 7.5, merchant: merchant1)
      item3 = FactoryBot.create(:item, name: 'ccc', unit_price: 10.0, merchant: merchant1)

      expect(Item.find_by_max_price(8)).to eq(item1)
    end
  end

  describe '#find_top_items_revenue' do
    it 'finds the top items by revenue and returns the amount specified' do
      merchant_1 = FactoryBot.create(:merchant)
      merchant_2 = FactoryBot.create(:merchant)
      merchant_3 = FactoryBot.create(:merchant)

      item_1 = FactoryBot.create(:item, merchant: merchant_1, unit_price: 1000)
      item_2 = FactoryBot.create(:item, merchant: merchant_2, unit_price: 1200)
      item_3 = FactoryBot.create(:item, merchant: merchant_3, unit_price: 500)

      customer = FactoryBot.create(:customer)

      invoice_1 = Invoice.create!(status: "shipped", customer: customer)

      transaction = Transaction.create!(result: "success", invoice: invoice_1)

      invoice_item_1 = FactoryBot.create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 1000, quantity: 1)
      invoice_item_2 = FactoryBot.create(:invoice_item, item: item_2, invoice: invoice_1, unit_price: 1200, quantity: 1)
      invoice_item_3 = FactoryBot.create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 500, quantity: 1)

      expect(Item.find_top_items_revenue(2)[0]).to eq(item_2)
      expect(Item.find_top_items_revenue(2)[1]).to eq(item_1)
    end
  end
end