class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates :unit_price, presence: true, numericality: { only_float: true }

  def self.find_one_by_name(search)
    where('lower(name) LIKE ?', "%#{search.downcase}%")
    .order(:name)[0]
  end

  def self.find_all_by_name(search)
    where('lower(name) LIKE ?', "%#{search.downcase}%")
  end

  def self.find_by_price_range(min, max)
    where("items.unit_price >= #{min.to_f} AND items.unit_price <= #{max.to_f}")
    .order(:name)[0]
  end

  def self.find_by_min_price(price)
    where('unit_price >= ?', "#{price.to_f}")
    .order(:name)[0]
  end

  def self.find_by_max_price(price)
    where('unit_price <= ?', "#{price.to_f}")
    .order(:name)[0]
  end

  def self.find_top_items_revenue(item_amount)
    joins(invoice_items: {invoice: :transactions})
    .where("transactions.result = ?", 'success')
    .where("invoices.status = ?", 'shipped')
    .group(:id)
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .order(revenue: :desc)
    .limit(item_amount)
  end
end