module Moysklad::Resources
  class EmbeddedEntityMetadataIndexed < Indexed
    def subresource_by_name name
      Subresource.new findWhere(name: name.to_s).attributeMetadata
    end
  end
end
