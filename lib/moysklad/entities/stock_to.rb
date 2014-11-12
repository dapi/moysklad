module Moysklad::Entities
  class StockTO < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'stockTO'

    attribute :productCode,  String
    attribute :uomName,      String

    attribute :quantity,     Float  # Доступный остаток на склада
    attribute :reserve,      Float  # Сколько в резерве
    attribute :stock,        Float  # Остаток на складе не считая резерва

    attribute :inTransit,    Float
    attribute :sumTotal,     Float
    attribute :saleAmount,   Float
    attribute :minimumBalance, Float
    attribute :category,     String
    attribute :externalCode, String
    attribute :parentUuid,   String
    attribute :defaultConsignment, Boolean
    attribute :salePrice,   Float

    # Есть только при showConsignments
    attribute :consignmentName, String
    attribute :consignmentUuid, String

    element   :goodRef,  Moysklad::Entities::GoodRef

  end
end

