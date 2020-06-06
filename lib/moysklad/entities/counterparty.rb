module Moysklad::Entities
  class Counterparty < Entity
    attribute :email, String
    attribute :phone, String
    attribute :fax, String
    attribute :tags, Array[String]

    attribute :actualAddress, String
    attribute :legalTitle, String
    attribute :legalAddress, String
    attribute :inn, String
    attribute :kpp, String
    attribute :ogrn, String
    attribute :okpo, String

    attribute :description, String
    
    attribute :syncid, String
  end
end
