module Moysklad::Entities
  class AttributeValue < Virtus::Attribute
    def coerce(value)
      case value
      when String, Float
        value
      when Hash
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
