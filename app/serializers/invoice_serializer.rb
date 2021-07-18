class InvoiceSerializer
  include JSONAPI::Serializer

  set_type :invoice
  attributes :status
end
