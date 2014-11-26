module Moysklad::Entities
  class Attribute < Base
    include Moysklad::Entities::Common

    tag 'attribute'

    attribute :metadataUuid,    String
    attribute :valueString,     String
    attribute :valueText,       String

    attribute :entityValueUuid, String

    # Объект описывающий тип атритуба
    def attributeMetadata universe
      universe.metadata.subresource_by_name 'GoodFolder', metadataUuid
    end

    def attributeName universe
      attributeMetadata(universe).name
    end

    def get_value universe
      case attributeMetadata(universe).attrType
      when 'ID_CUSTOM'
        universe.custom_entities.find( entityValueUuid ).name
      when 'TEXT'
        valueText
      when 'STRING'
        valueString
      else
        raise "Не известный тип мета-аттрибута #{attributeMetadata.uuid}: #{attributeMetadata.attrType}"
      end
    end
  end
end
