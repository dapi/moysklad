require_relative 'entity'
require_relative 'uom'
require_relative 'owner'
require_relative 'group'
require_relative 'price'

module Moysklad::Entities
  class Service < Entity
    attribute :accountId,         String
    attribute :owner,             Owner
    attribute :group,             Group
    attribute :vat, Float
    attribute :effectiveVat, Float
    attribute :pathName,          String
    attribute :productFolder,     Productfolder
    attribute :description,       String

    attribute :uom,               Uom

    attribute :minPrice,          Float
    attribute :salePrices,        Array[Price]

    # Когда загружаем через ассортименты эти поля устанавливаются
    # attribute :stock, Float
    # attribute :reserve, Float
    # attribute :inTransit, Float
    # attribute :quantity, Float
  end
end
