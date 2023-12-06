module Moysklad::Entities
  class Meta < Base
    attribute :href,         String
    attribute :metadataHref, String
    attribute :type,         String
    attribute :mediaType,    String # application/json
    attribute :downloadHref, String

    def id
      @id ||= href.split('/').last
    end
  end
end
