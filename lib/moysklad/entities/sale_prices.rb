module Moysklad::Entities
  class SalePrices < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'salePrices'

    has_many :price, Moysklad::Entities::SalePrice
  end
end
