module Moysklad::Resources
  class Indexed  < SimpleDelegator
    WrongEntriesCountError = Class.new StandardError
    NoIdInEntity  = Class.new StandardError

    include WhereFilter
    include LoadAll
    include IndexedCache

    def initialize resource
      raise TypeError, 'resource должен быть Moysklad::Resources::Base' unless resource.is_a? Moysklad::Resources::Base
      super resource
    end

    # Автоматически подгружает постранично данныез из API и возвращает их все сразу.
    #
    # @return [Array of Moysklad::Entities::Base]
    def all(params = {})
      cache_fetch do
        pull_list(params)
      end
    end

    # Возвращает запрашивемую запись из кеша.
    # Предварительно подгружает все записи через метод `all`
    #
    # @return Moyskald::Entities::Base
    def find id
      index[id]
    end

    # Перечень id-ов всех элементов в ресуресе
    #
    # @return [Array of uuids]
    def uuids
      index.keys
    end

    # Неиндексированный ресурс
    #
    # @return Moysklad::Resources::Base
    def resource
      __getobj__
    end

    private

    def values
      index.values
    end

    def index
      pull_list unless cached_index
      cached_index
    end

    def pull_list(params={})
      load_all(params)
    end

    def prepare_index list
      i={}
      list.each do |r|
        raise NoIdInEntity, "У объекта нет id: #{r}" unless r.respond_to?(:id) && r.id
        i[r.id]=r
      end
      return i
    end
  end
end
