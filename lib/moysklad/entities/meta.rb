module Moysklad::Entities
  class Meta < Base
    attribute :href, String
    attribute :metadataHref, String
    attribute :type, String
    attribute :mediaType, String # application/json

    def id
      @id ||= href.split('/').last
    end
  end
end
