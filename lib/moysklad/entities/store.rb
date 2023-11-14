module Moysklad::Entities
  class Store < Entity
    include AttributesConverter
    attribute :address, String
    attribute :description, String
    attribute :parent, Hash
    attribute :pathName, String
    attribute :attrs, Array
  end
end
