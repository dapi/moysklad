module Moysklad::Entities
  class ImagesMeta < Base
    attribute :href, String
    attribute :type, String
    attribute :mediaType, String
    attribute :size, Integer
    attribute :limit, Integer
    attribute :offset, Integer
  end

  class Images < Base
    attribute :meta, ImagesMeta
  end
end

