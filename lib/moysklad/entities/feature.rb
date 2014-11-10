module Moysklad::Entities
  class Feature < Base
    include CommonObject

    tag 'feature'

    attribute :goodUuid,    String

    attribute :archived,    Boolean

    has_many :attribute, Moysklad::Entities::Attribute

    has_many :barcode, Moysklad::Entities::Barcode

  end
end
