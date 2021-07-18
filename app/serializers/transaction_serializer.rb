class TransactionSerializer
  include JSONAPI::Serializer

  set_type :transaction
  attributes :credit_card_number, :credit_card_expiration_date, :result
end
