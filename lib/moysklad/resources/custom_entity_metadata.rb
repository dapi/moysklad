module Moysklad::Resources
  # Список аттрибутов, которые используются как свойства товара
  # https://online.moysklad.ru/api/remap/1.1/entity/companysettings/metadata/
  # https://online.moysklad.ru/api/remap/1.1/entity/variant/metadata/
  # https://online.moysklad.ru/api/remap/1.1/entity/product/metadata/
  class CustomEntityMetadata < Base

    def list(_params)
      raise
    end

    private

    def prefix_path
      'entity/companysettings/metadata/customEntities/'
    end

    def list_path
      raise 'Список напрямую получить не возможно'
    end
  end
end
