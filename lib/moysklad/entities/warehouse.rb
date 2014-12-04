module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Warehouse/list
  class Warehouse < Base
    include CommonObject

    tag 'warehouse'

    attribute :agentUuid,    String
    attribute :archived,     Boolean
    attribute :code,         String

    element   :contact,      Contact
    has_many  :slots,        Slot
  end
end
