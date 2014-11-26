module Moysklad::Entities
  class Attribute < Base
    include Moysklad::Entities::Common

    tag 'attribute'

    attribute :metadataUuid,    String
    attribute :valueString,     String

    attribute :entityValueUuid, String

  end
end
