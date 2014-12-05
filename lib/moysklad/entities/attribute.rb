module Moysklad::Entities
  class Attribute < Base
    include Moysklad::Entities::Common

    tag 'attribute'

    attribute :metadataUuid,    String
    attribute :valueString,     String
    attribute :valueText,       String

    attribute :entityValueUuid, String

    # Объект описывающий тип атритуба
    #
    # @return Moysklad::Entities::AttributeMetadata
    #
    def metadata universe
      universe.metadata.subresource_by_name(:GoodFolder).find metadataUuid
    end

    # Название свойства, полученное из AttributeMetadata
    #
    # @return String
    #
    def attributeName universe
      metadata(universe).name
    end

    # Значение свойства согласно его типу
    #
    # @return [String | Moysklad::Entities::CustomEntity | Integer | Decimal ]
    def get_value universe
      md = metadata universe
      case md.attrType
      when 'ID_CUSTOM'
        universe.custom_entities.find( entityValueUuid ).name
      when 'TEXT'
        valueText
      when 'STRING'
        valueString
        # TODO Другие типы
      else
        raise "Не известный тип мета-аттрибута #{md.uuid}: #{md.attrType}"
      end
    end
  end
end
