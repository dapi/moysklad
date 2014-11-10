module Moysklad::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Consignment/list
  class Consignment < Base
    include Common

    tag 'consignment'

    attribute :updated,      Time
    attribute :updatedBy,    String

    attribute :name,         String

    attribute :goodUuid,     String
    attribute :isDefault,    Boolean

    attribute :archived,     Boolean

    element   :externalcode, String

    has_one   :feature,      Moysklad::Entities::Feature
  end
end
