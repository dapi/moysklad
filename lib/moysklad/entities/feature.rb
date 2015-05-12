module Moysklad::Entities
  class Feature < Base
    include CommonObject

    tag 'feature'

    attribute :goodUuid,    String

    attribute :archived,    Boolean
    attribute :isDefault,   Boolean

    element   :shared,      Boolean

    has_many  :attributes,  Moysklad::Entities::Attribute
    has_many  :barcodes,    Moysklad::Entities::Barcode

    def good universe
      cache :good, universe do
        universe.good.find goodUuid
      end
    end
  end
end
