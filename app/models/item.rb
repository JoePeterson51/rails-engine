class Item < ApplicationRecord
  attr_accessor :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
end