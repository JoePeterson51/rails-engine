class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.find_revenue_between_dates(start_date, end_date)
    joins(:transactions)
    .joins(:invoice_items)
    .where("transactions.result = ?", 'success')
    .where("invoices.status = ?", 'shipped')
    .where('invoices.created_at BETWEEN ? AND ?', start_date, end_date)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.find_unshipped_potential_revenue(invoice_amount)
    joins(:transactions)
    .joins(:invoice_items)
    .where("transactions.result = ?", 'success')
    .where("invoices.status != ?", 'shipped')
    .group(:id)
    .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue")
    .order(potential_revenue: :desc)
    .limit(invoice_amount)
  end
end