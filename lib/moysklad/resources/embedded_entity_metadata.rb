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

    def self.indexed *args
      Moysklad::Resources::EmbeddedEntityMetadataIndexed.new new(*args)
    end

  end
end
