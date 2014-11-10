module Moysklad::Entities
  class Company < Base
    include CompanyConcern

    tag 'company'

    attribute :payerVat,    Boolean

    attribute :priceTypeUuid, String

    attribute :discount,     Float
    attribute :autoDiscount, Float
    attribute :discountCardNumber, String
    attribute :discountCorrection, Float

    element   :code,         String
  end
end


