class MerchantRevenueSerializer
  include JSONAPI::Serializer

  set_type :merchant_revenue
  attributes :name, :revenue
end