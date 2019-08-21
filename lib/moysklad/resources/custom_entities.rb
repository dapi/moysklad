module Moysklad::Resources
  # Элементы словаря
  class CustomEntities < Base
    # custom_entity_meta_id - id словаря, элементы которого хотим получить
    def initialize(custom_entity_meta_id: nil, client: nil, list_path: nil)
      raise 'Client empty' if client.nil? # support ruby 2.0.0

      @custom_entity_meta_id = custom_entity_meta_id
      super client: client, list_path: list_path
    end

    # Публичный чтобы был доступен из индекса
    def cache_key
      [list_path, custom_entity_meta_id].join(':')
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
