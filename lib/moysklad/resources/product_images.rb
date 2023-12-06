module Moysklad::Resources
  class ProductImages < Base
    # Публичный чтобы был доступен из индекса
    def cache_key
      [list_path].join(':')
    end

    private

    def item_path
      raise
    end
  end
end
