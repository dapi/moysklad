module Moysklad::Entities
  class CustomEntity < Base
    include CommonObject

    tag 'customEntity'

    attribute :entityMetadataUuid,     String 

  end
end
