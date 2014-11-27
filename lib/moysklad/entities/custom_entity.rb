# https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntity/list
# Элемент пользовательского справочника
# (значения перечисляемых свойств)
module Moysklad::Entities
  class CustomEntity < Base
    include CommonObject
    include XmlFix

    tag 'customEntity'

    attribute :entityMetadataUuid,     String 

    def entityMetadata universe
      universe.custom_entity_metadata.find entityMetadataUuid
    end

  end
end
