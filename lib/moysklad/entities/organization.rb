require_relative 'entity'

module Moysklad::Entities
  class Organization < Entity
    attribute :externalCode, String
  end
end
