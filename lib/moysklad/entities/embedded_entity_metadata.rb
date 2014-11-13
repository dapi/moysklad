module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Metadata/list
  class EmbeddedEntityMetadata < Base
    include CommonObject

    tag 'embeddedEntityMetadata'

    attribute :uniqueCode,               Boolean
    attribute :codeValueType,            Integer
    attribute :independentNameGenerator, Boolean
    attribute :partialReserve,           Boolean

    has_many  :attributeMetadata,        AttributeMetadata

    element :code,          String
  end
end

