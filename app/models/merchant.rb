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
end