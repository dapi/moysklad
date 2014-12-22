module Moysklad::Entities
  class SalePrice < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'price'

    attribute :currencyUuid,  String
    attribute :priceTypeUuid, String
    attribute :value, Float

    def priceType universe
      cache :priceType, universe do
        universe.price_types.find priceTypeUuid
      end
    end
  end
end
