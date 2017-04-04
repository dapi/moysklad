require_relative 'base'

module Moysklad::Entities
  class Meta < Base
    attribute :href, String
    attribute :metadataHref, String
    attribute :type, String
    attribute :mediaType, String # application/json
  end
end
