class InvoiceItem < ApplicationRecord
  attr_accessor :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
end