module Moysklad::Entities
  class Image < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'image'

    attribute :created,  Time
    attribute :updated,  Time
    attribute :updatedBy,  String
    attribute :name,  String
    attribute :tinyUuid, String
    attribute :filename, String
    attribute :miniatureUuid, String

    attribute :accountUuid, String
    attribute :accountId, String
    attribute :uuid, String
    attribute :externalcode, String
  end
end
