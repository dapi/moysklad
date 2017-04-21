require_relative 'base'
require_relative 'currency'

module Moysklad::Entities
  class Rate < Base
    attribute :currency, Currency
    attribute :value, Integer
  end
end
