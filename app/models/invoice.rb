class Invoice < ApplicationRecord
  attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
end