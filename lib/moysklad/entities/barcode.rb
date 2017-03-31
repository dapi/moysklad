module Moysklad::Entities
  class Barcode < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'barcode'

    attribute :barcode,     String
    attribute :barcodeType, String

    attribute :accountUuid, String
    attribute :accountId,   String
    attribute :uuid,        String
    attribute :groupUuid,   String
    attribute :ownerUuid,   String

    attribute :shared,      Boolean
  end
end
