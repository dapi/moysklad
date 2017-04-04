require_relative 'base'
require_relative 'attribute_metadata'
require_relative 'characteristic_metadata'
require_relative 'price_type'
require_relative 'attributes_support'

module Moysklad::Entities
  class ResourceMetadata < Base
    include AttributesSupport

    attribute :meta, Meta
    attribute :attrs, Array[AttributeMetadata]
    attribute :characteristics, Array[CharacteristicMetadata]
    attribute :priceTypes, Array[PriceType]
  end
end
