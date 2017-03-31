module Moysklad::Entities
  class Good < Base
    include CommonObject
    include Moysklad::Entities::XmlFix

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

    element   :code,              String
    element   :salePrices,        Moysklad::Entities::SalePrices

    has_many  :attributes,        Attribute
    element   :images,            Moysklad::Entities::Images
    element   :barcode,           Moysklad::Entities::Barcode
    # preferences

    def features universe
      cache :features, universe do
        universe.features.where goodUuid: uuid
      end
    end
  end
end
