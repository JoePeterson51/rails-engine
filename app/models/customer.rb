class Customer < ApplicationRecord
  attr_accessor :id, :first_name, :last_name, :created_at, :updated_at

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
end