module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/MyCompany/list
  class MyCompany < Base
    include Moysklad::Entities::CompanyConcern

    tag 'myCompany'

    attribute :director,    String
    attribute :chiefAccountant, String

  end
end
