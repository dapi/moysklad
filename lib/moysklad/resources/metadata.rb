module Moysklad::Resources
  class Metadata < Base
    def self.entity_class
      Moysklad::Entities::EmbeddedEntityMetadata
    end

    def self.type
      'Metadata'
    end

    def self.pluralized_type
      :metadata
    end

    def self.indexed *args
      Moysklad::Resources::MetadataIndexed.new new(*args)
    end

  end
end
