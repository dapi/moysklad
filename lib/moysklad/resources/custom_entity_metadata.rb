module Moysklad::Resources
  # https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntityMetadata/list
  # Список аттрибутов, которые используются как свойства товара
  class CustomEntityMetadata < Base
    def self.entity_class
      Moysklad::Entities::CustomEntityMetadata
    end

    def self.type
      'CustomEntityMetadata'
    end

    def self.pluralized_type
      :custom_entity_metadata
    end

  end
end
