module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Warehouse/list
  class Contact < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'warehouse'

    attribute :address,    String
    attribute :faxes,      String
    attribute :mobiles,    String
    attribute :email,      String

  end
end
