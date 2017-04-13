require_relative 'meta'

module Moysklad::Entities
  class EntityMeta < Base
    attribute :href, String
    attribute :type, String
    attribute :mediaType, String
  end

  class CompanySettingsCustomEntity < Base
    attribute :meta, Meta
    attribute :entityMeta, EntityMeta
    attribute :name, String

    def id
      meta.id
    end

    def entities(universe)
      Moysklad::Resources::CustomEntities.indexed(client: universe.client, list_path: entityMeta.href).all
    end
  end

  class CompanySettingsMetadata < Base
    attribute :meta, Meta
    attribute :customEntities, Array[CompanySettingsCustomEntity]
  end
end
