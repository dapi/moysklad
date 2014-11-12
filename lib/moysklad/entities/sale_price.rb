module Moysklad::Entities
  class SalePrice < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'price'

    attribute :currencyUuid,  String
    attribute :priceTypeUuid, String
    attribute :value, Float
  end
end
