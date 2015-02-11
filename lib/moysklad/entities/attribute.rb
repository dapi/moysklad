module Moysklad::Entities
  class Attribute < Base
    include Moysklad::Entities::Common

    tag 'attribute'

    # 
    attribute :metadataUuid,    String
    attribute :valueString,     String
    attribute :valueText,       String
    attribute :doubleValue,     Float
    attribute :longValue,       Integer
    attribute :booleanValue,    Boolean
    attribute :timeValue,       String

    attribute :agentValueUuid, String
    attribute :goodValueUuid, String
    attribute :placeValueUuid, String
    attribute :consignmentValueUuid, String
    attribute :employeeValueUuid, String
    attribute :projectValueUuid, String
    attribute :contractValueUuid, String

    attribute :file, Moysklad::Entities::AttachmentDocument

    attribute :entityValueUuid, String

    # Объект описывающий тип атритуба
    #
    # @return Moysklad::Entities::AttributeMetadata
    #
    def metadata universe
      universe.embedded_entity_metadata.subresource_by_name(:GoodFolder).find metadataUuid
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
      when 'LINK'
        valueText
      when 'TEXT'
        valueText
      when 'STRING'
        valueString
      when 'DOUBLE'
        doubleValue
      when 'LONG'
        longValue
      when 'TIME'
        timeValue
      when 'FILE'
        file
      else
        raise "Не известный тип мета-аттрибута #{md.uuid}: #{md.attrType}"
      end
    end
  end
end
