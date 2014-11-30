module Moysklad::Entities
  class Price < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    def self.from_money money
      p = new
      p.sumInCurrency = p.sum = money.cents
      p
    end

    attribute :sumInCurrency, Float
    attribute :sum,           Float
  end
end
