require_relative 'entity'
module Moysklad::Entities
  class Consignment < Entity
    attribute :meta, Meta
    attribute :id,                String
    attribute :version,           Integer
    attribute :updated,           String
    attribute :name,              String
    attribute :label,              String
    attribute :externalCode,      String
    attribute :archived,          Boolean

    attribute :accountId,         String
    attribute :assortment,        Hash # Assortment

    # Когда загружаем через ассортименты эти поля устанавливаются
    attribute :stock, Float
    attribute :reserve, Float
    attribute :inTransit, Float
    attribute :quantity, Float
  end
end
