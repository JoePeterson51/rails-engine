class InvoiceItemSerializer
  include JSONAPI::Serializer

  set_type :invoice_item
  attributes :quantity, :unit_price
end
