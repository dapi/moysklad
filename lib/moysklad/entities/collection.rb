require_relative 'context'
require_relative 'collection_meta'

module Moysklad::Entities
  class RowItems < Virtus::Attribute
    include ActiveSupport::Inflector

    def coerce(items)
      items.map do |item|
        type = item['meta']['type']
        entity_class = find_entity_class type
        entity_class.new item
      end
    end

    private

    def find_entity_class(type)
      case type
      when 'customentity'
        Moysklad::Entities::CustomEntity
      else
        constantize 'Moysklad::Entities::' + camelize(type)
      end
    rescue NameError
      raise Moysklad::Error, "No entity class for #{type} type"
    end
  end

  class Collection < Base
    attribute :context, Context
    attribute :meta, CollectionMeta
    attribute :rows, RowItems
  end
end
