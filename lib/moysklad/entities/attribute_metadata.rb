module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Metadata/list
  class AttributeMetadata < Base
    include CommonObject

    tag 'attributeMetadata'

    # ID_CUSTOM - элемент из dictionary
    # TEXT
    # STRING
    attribute :attrType,            String
    attribute :entityMetadataUuid,  String
    attribute :feature,             Boolean
    attribute :position,            Integer
    attribute :required,            Boolean
    attribute :dictionaryMetadataUuid, String

    def is_dictionary?
      attrType == 'ID_CUSTOM'
    end

    # Если это свойство типа ID_CUSTOM, то возвращается пользовательский справочник
    #
    # @return Moysklad::Entities::CustomEntityMetadata
    def dictionatyMetadata universe
      raise "Это свойства не типа справочник" unless dictionaryMetadataUuid
      universe.custom_entity_metadata.find dictionaryMetadataUuid
    end

    # Справочник к которому принадлежит это ссвойство
    #
    # @return Moysklad::Entities::EmbeddedEntityMetadata
    def entityMetadata universe
      universe.metadata.find entityMetadataUuid
    end

  end
end
