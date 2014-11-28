module Moysklad::Entities
  class Feature < Base
    include CommonObject

    tag 'feature'

    attribute :goodUuid,    String

    attribute :archived,    Boolean

    has_many  :attributes,  Moysklad::Entities::Attribute
    has_many  :barcodes,    Moysklad::Entities::Barcode

  end
end
