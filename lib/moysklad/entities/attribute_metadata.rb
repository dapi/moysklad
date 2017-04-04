require_relative 'attribute_value'

module Moysklad::Entities
  class AttributeMetadata < Base
    attribute :meta, Meta
    attribute :id, String
    attribute :name, String
    attribute :type, String # string, customentity
    attribute :required, Boolean
  end
end
