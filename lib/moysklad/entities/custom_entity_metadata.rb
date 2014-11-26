# https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntity/list
# Значения перечисляемых свойств
module Moysklad::Entities
  class CustomEntityMetadata < Base
    include CommonObject

    tag 'customEntityMetadata'

    attribute :uniqueCode,     Boolean 
    attribute :codeValueType,  Integer
    attribute :independentNameGenerator, Boolean

    attribute :partialReserve, Boolean

    attribute :editOnlyByAuthor, Boolean

    attribute :noEditFromOtherPlaceSource, Boolean

    attribute :noApplicableFromOtherPlaceSource, Boolean

    attribute :noEditFromOtherPlaceTarget, Boolean

    attribute :noApplicableFromOtherPlaceTarget, Boolean

    def entities universe
      universe.custom_entities.where entityMetadataUuid: uuid
    end

  end
end
