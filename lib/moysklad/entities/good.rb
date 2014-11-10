module Moysklad::Entities
  class Good < Base
    include CommonObject

    tag 'good'

    attribute :isSerialTrackable, Boolean

    attribute :buyPrice,          Float
    attribute :buyCurrencyUuid,   String

    attribute :minPrice,          Float

    attribute :salePrice,         Float
    attribute :saleCurrencyUuid,  String

    attribute :weight,            Float
    attribute :volume,            Float

    attribute :parentUuid,        String

    attribute :productCode,       String

    attribute :uomUuid,           String

    element :code,          String

    element :salePrices,          Moysklad::Entities::SalePrices

  end
end
