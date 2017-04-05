require_relative 'meta'
raise 'не используется'
module Moysklad::Entities
  class CustomEntityMetadata < Base
    attribute :meta, Meta
    attribute :id, String
    attribute :name, String
    attribute :type, String # string, customentity
    attribute :required, Boolean
  end
end
