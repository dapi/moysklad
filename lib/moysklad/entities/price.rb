require_relative 'currency'
module Moysklad::Entities
  class Price < Base
    attribute :value, Float
    attribute :currency, Currency
    attribute :priceType, String # Цена продажи/ Распродажа

    def self.from_money money
      raise 'not implemented'
    end
  end
end
