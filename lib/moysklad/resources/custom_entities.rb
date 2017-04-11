module Moysklad::Resources
  # Элементы словаря
  class CustomEntities < Base
    # custom_entity_meta_id - id словаря, элементы которого хотим получить
    def initialize custom_entity_meta_id: nil, client:, list_path: nil
      @custom_entity_meta_id = custom_entity_meta_id
      super client: client, list_path: list_path
    end

    private

    attr_reader :custom_entity_meta_id

    def item_path
      raise
    end

    def list_path
      @list_path || (prefix_path + '/' + custom_entity_meta_id.to_s)
    end
  end
end