require_relative 'uom'

module Moysklad::Entities
  class Assortment < Product
    attribute :stock, Float
    attribute :reserve, Float
    attribute :inTransit, Float
    attribute :quantity, Float
  end
end
