module Moysklad::Entities
  class SalePrice < Base
    include HappyMapper

    tag 'price'

    attribute :currencyUuid,  String
    attribute :priceTypeUuid, String
    attribute :value, Float
  end
end
