class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_one_by_name(search)
    Merchant.where('lower(name) LIKE ?', "%#{search.downcase}%")
    .order(:name)[0]
  end

  def self.find_all_by_name(search)
    Merchant.where('lower(name) LIKE ?', "%#{search.downcase}%")
  end

  def self.find_top_revenue(merchant_amount)
    joins(items: {invoice_items: {invoice: :transactions}})
    .where("transactions.result = ?", 'success')
    .where("invoices.status = ?", 'shipped')
    .group(:id)
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .order(revenue: :desc)
    .limit(merchant_amount)
  end

  def self.most_items_sold(merchant_amount)
    joins(items: {invoice_items: {invoice: :transactions}})
    .where("transactions.result = ?", 'success')
    .group(:id)
    .select("merchants.*, sum(invoice_items.quantity) as count")
    .order("count desc")
    .limit(merchant_amount)
  end

  def merchants_total_revenue
    items.joins(invoice_items: {invoice: :transactions})
    .where("transactions.result = ?", 'success')
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end