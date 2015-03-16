module Moysklad::Entities
  class GoodFolder < Base
    include CommonObject

    tag 'goodFolder'

    attribute :productCode,   String
    attribute :parentUuid,    String
  end
end
