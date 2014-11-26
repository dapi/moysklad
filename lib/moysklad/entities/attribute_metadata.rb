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

  end
end
