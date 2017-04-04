require_relative 'custom_entity'

module Moysklad::Entities
  class AttributeValue < Virtus::Attribute
    def coerce(value)
      if value.is_a? String
        value
      elsif value.is_a? ::Hash
        if value['meta']['type'] == 'customentity'
          CustomEntity.new value
        else
          raise "Unknown meta type: #{value['meta']['type']}"
        end
      else
        raise "Unknown value type (#{value}) #{value.class}"
      end
    end
  end
end
