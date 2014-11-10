module Moysklad::Entities
  class CustomerOrderPosition < Base
    include HappyMapper

    tag 'customerOrderPosition'

    attribute :vat,       Integer
    attribute :goodUuid,  String
    attribute :consignmentUuid, String
    attribute :quantity,  Float
    attribute :discount,  Float
    attribute :consignmentUuid, String

    element :deleted,   Time

    element :basePrice, Moysklad::Entities::Price, tag: :basePrice
    element :price,     Moysklad::Entities::Price, tag: :price
    element :reserve,   Float
  end

end
