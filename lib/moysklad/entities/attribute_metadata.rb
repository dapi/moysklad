require_relative 'attribute_value'

module Moysklad::Entities
  class AttributeMetadata < Base
    attribute :meta, Meta
    attribute :id, String
    attribute :name, String
    attribute :type, String # string, customentity
    attribute :required, Boolean
    attribute :customEntityMeta, Meta

    def is_dictionary?
      type == 'customentity'
    end
  end
end
