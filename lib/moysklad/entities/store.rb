require_relative 'entity'
module Moysklad::Entities
  class Store < Entity
    attribute :address, String
  end
end
