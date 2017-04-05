require_relative 'base'
require_relative 'attribute_metadata'
require_relative 'characteristic_metadata'
require_relative 'price_type'

module Moysklad::Entities
  class ResourceMetadata < Base
    attribute :meta, Meta
    attribute :attrs, Array[AttributeMetadata]
    attribute :characteristics, Array[CharacteristicMetadata]
    attribute :priceTypes, Array[PriceType]
  end
end
