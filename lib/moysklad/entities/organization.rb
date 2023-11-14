module Moysklad::Entities
  class Organization < Entity
    include AttributesConverter
    attribute :externalCode, String
    attribute :archived, Boolean
    attribute :companyType, String
    attribute :legalTitle, String
    attribute :legalAddress, String
    attribute :inn, String
    attribute :okpo, String
    attribute :email, String
    attribute :phone, String
    attribute :director, String
    attribute :payerVat, Boolean
    attribute :isEgaisEnable, Boolean
    attribute :attrs, Array[Hash]
  end
end
