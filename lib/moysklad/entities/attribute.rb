module Moysklad::Entities
  class Attribute < Base
    include Moysklad::Entities::Common

    tag 'attribute'

    attribute :metadataUuid, String
    attribute :valueString, String

  end
end
