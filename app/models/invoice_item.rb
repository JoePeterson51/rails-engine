class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item

  def self.find_revenue_between_dates(start, end_date)
    joins({invoice: :transactions})
    .where("invoices.created_at >= '#{start}' AND invoices.created_at <= '#{end_date}'")
    .where("transactions.result = ?", 'success')
    .group(:id)
    .select("invoice_items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").inject(0) do |acc, record|
      acc + record.revenue
    end
  end
end