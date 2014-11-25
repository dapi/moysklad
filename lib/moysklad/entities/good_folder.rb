module Moysklad::GoodFolder
  class Good < Base
    include CommonObject

    tag 'goodFolder'

    attribute :productCode,   String
  end
end
