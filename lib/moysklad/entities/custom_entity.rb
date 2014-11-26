# https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntity/list
# Значения перечисляемых свойств
module Moysklad::Entities
  class CustomEntity < Base
    include CommonObject

    tag 'customEntity'

    attribute :entityMetadataUuid,     String 

  end
end
