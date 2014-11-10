module Moysklad::Entities
  class Attribute < Base
    include Common

    tag 'attribute'

    attribute :metadataUuid, String
    attribute :valueString, String

  end
end
