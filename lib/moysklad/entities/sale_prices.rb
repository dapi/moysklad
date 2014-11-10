module Moysklad::Entities
  class SalePrices < Base
    include HappyMapper

    tag 'salePrices'

    has_many :price, Moysklad::Entities::SalePrice
  end
end
