# Атрибут товара (ссылка на его тип и его значение)
module Moysklad::Entities
  class Attribute < Base
    attribute :meta, Meta
    attribute :id, String
    attribute :name, String
    attribute :customEntityMeta, Meta
    attribute :type, String #attributemetadata
    attribute :value, AttributeValue
    attribute :required, Boolean

    def to_s
      "#{name} (#{type}): #{value}"
    end

    def is_dictionary?
      type == 'customentity'
    end

    ### Если это свойство типа ID_CUSTOM, то возвращается пользовательский справочник
    ###
    ### @return Moysklad::Entities::CustomEntityMetadata
    ##def dictionatyMetadata universe
    ##raise "Это свойства не типа справочник" unless dictionaryMetadataUuid
    ##universe.custom_entity_metadata.find dictionaryMetadataUuid
    ##end

    ### Справочник к которому принадлежит это ссвойство
    ###
    ### @return Moysklad::Entities::EmbeddedEntityMetadata
    ##def entityMetadata universe
    ##universe.embedded_entity_metadata.find entityMetadataUuid
    ##end


    ### Объект описывающий тип атритуба
    ###
    ### @return Moysklad::Entities::AttributeMetadata
    ###
    ##def metadata universe
    ##universe.embedded_entity_metadata.subresource_by_name(:GoodFolder).find metadataUuid
    ##end

    ### Название свойства, полученное из AttributeMetadata
    ###
    ### @return String
    ###
    ##def attributeName universe
    ##metadata(universe).name
    ##end

    ### Значение свойства согласно его типу
    ###
    ### @return [String | Moysklad::Entities::CustomEntity | Integer | Decimal ]
    #def get_value universe
      #md = metadata universe
      #case md.attrType
      #when 'ID_CUSTOM'
        #universe.custom_entities.find( entityValueUuid ).name
      #when 'LINK'
        #valueText
      #when 'TEXT'
        #valueText
      #when 'STRING'
        #valueString
      #when 'DOUBLE'
        #doubleValue
      #when 'LONG'
        #longValue
      #when 'TIME'
        #timeValue
      #when 'FILE'
        #file
      #else
        #raise "Не известный тип мета-аттрибута #{md.uuid}: #{md.attrType}"
      #end
    #end
    ### Объект описывающий тип атритуба
    ###
    ### @return Moysklad::Entities::AttributeMetadata
    ###
    ##def metadata universe
    ##universe.embedded_entity_metadata.subresource_by_name(:GoodFolder).find metadataUuid
    ##end

    ### Название свойства, полученное из AttributeMetadata
    ###
    ### @return String
    ###
    ##def attributeName universe
    ##metadata(universe).name
    ##end

    ### Значение свойства согласно его типу
    ###
    ### @return [String | Moysklad::Entities::CustomEntity | Integer | Decimal ]
    ##def get_value universe
    ##md = metadata universe
    ##case md.attrType
    ##when 'ID_CUSTOM'
    ##universe.custom_entities.find( entityValueUuid ).name
    ##when 'LINK'
    ##valueText
    ##when 'TEXT'
    ##valueText
    ##when 'STRING'
    ##valueString
    ##when 'DOUBLE'
    ##doubleValue
    ##when 'LONG'
    ##longValue
    ##when 'TIME'
    ##timeValue
    ##when 'FILE'
    ##file
    ##else
    ##raise "Не известный тип мета-аттрибута #{md.uuid}: #{md.attrType}"
    ##end
    ##end
  end
end
