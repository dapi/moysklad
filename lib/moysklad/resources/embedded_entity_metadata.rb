module Moysklad::Resources
  class EmbeddedEntityMetadata < Base
    def self.entity_class
      Moysklad::Entities::EmbeddedEntityMetadata
    end

    def self.type
      'EmbeddedEntityMetadata'
    end

    def self.pluralized_type
      :embedded_entity_metadata
    end

    def self.indexed client: nil, list_path: nil
      Moysklad::Resources::EmbeddedEntityMetadataIndexed.new new(client: client, list_path: list_path)
    end
  end
end
