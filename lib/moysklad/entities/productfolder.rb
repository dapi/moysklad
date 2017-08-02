require_relative 'entity'

module Moysklad::Entities
  class Productfolder < Entity
    attribute :accountId,         String
    attribute :owner,             Owner
    attribute :group,             Group
    attribute :description,       String
    attribute :vat, Float
    attribute :effectiveVat, Float
    attribute :productFolder, self
  end
end
