module Moysklad::Entities
  # Пример:
  # https://support.moysklad.ru/hc/ru/articles/203402923-Пример-загрузки-заказа-покупателя-через-REST-API
  #
  class CustomerOrder < Base
    include CommonObject
    include XmlFix

    tag 'customerOrder'

    attribute :created,     Time 
    attribute :createdBy,   String

    attribute :reservedSum,     Float

    attribute :sourceStoreUuid, String
    attribute :sourceAccountUuid, String
    attribute :sourceAgentUuid, String

    attribute :targetAgentUuid, String
    attribute :targetAccountUuid, String

    attribute :applicable,      Boolean
    attribute :moment,          Time 

    attribute :payerVat,        Boolean

    attribute :consignmentUuid, String

    attribute :rate,            Float

    attribute :vatIncluded,     Boolean
    attribute :name,            String

    element   :sum,             Moysklad::Entities::Price, tag: :sum

    element   :deleted,         Time

    has_many  :customerOrderPosition, Moysklad::Entities::CustomerOrderPosition

  end
end
