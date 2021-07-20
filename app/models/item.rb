class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true

  def self.find_one_by_name(search)
    Item.where('lower(name) LIKE ?', "%#{search.downcase}%")
    .order(:name)[0]
  end

  def self.find_all_by_name(search)
    Item.where('lower(name) LIKE ?', "%#{search.downcase}%")
  end
end