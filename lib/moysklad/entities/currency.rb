require_relative 'meta'

module Moysklad::Entities
  class Currency < Base
    attribute :meta, Meta
    attribute :value, Float
  end
end
