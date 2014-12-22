module Moysklad::Entities
  class SalePrice < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'price'

    attribute :currencyUuid,  String
    attribute :priceTypeUuid, String
    attribute :value, Float

    def price_type universe
      cache :price_type, universe do
        universe.price_types.find priceTypeUuid
      end
    end
  end
end
