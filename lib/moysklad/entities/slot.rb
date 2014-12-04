module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Warehouse/list
  class Slot < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'slot'

  end
end
