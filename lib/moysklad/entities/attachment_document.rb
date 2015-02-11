module Moysklad::Entities
  class AttachmentDocument < Base
    include Moysklad::Entities::Common

    tag 'file'

    attribute :filename,       String
    attribute :miniatureUuid,  String
    attribute :name,           String

    #def self.parse node, options
      ## TODO create AttachmentDocument
      #''
    #end
  end
end
