# https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntityMetadata/list
#
# Пользовательские справочники
module Moysklad::Entities
  class CustomEntityMetadata < Base
    include CommonObject
    include XmlFix

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

    # Список перечисляемых значений данного справочника
    #
    # @return [Array[CustomEntity]]
    def entities universe
      universe.custom_entities.where entityMetadataUuid: uuid
    end

  end
end
