module Moysklad::Entities
  class ResourceMetadata < Base
    include AttributesConverter
    attribute :meta, Meta
    attribute :attrs, Array[AttributeMetadata]
    attribute :characteristics, Array[CharacteristicMetadata]
    attribute :priceTypes, Array[PriceType]
  end
end
