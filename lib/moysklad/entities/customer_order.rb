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

    attribute :stateUuid, String

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

    def state universe
      cache :customer_order_states, universe do
        fail "No stateUuid in CustomerOrder #{uuid}" unless stateUuid
        workflow = universe.workflows.findWhere name: 'CustomerOrder'
        workflow.states.find { |s| s.uuid == stateUuid }
      end
    end
  end
end
