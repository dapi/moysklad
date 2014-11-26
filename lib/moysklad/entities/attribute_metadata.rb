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

    def dictionatyMetadata universe
      universe.custom_entity_metadata.find dictionaryMetadataUuid
    end

    def entityMetadata universe
      universe.metadata.find entityMetadataUuid
    end

  end
end
