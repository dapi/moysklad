require_relative 'where_filter'
require_relative 'load_all'

module Moysklad::Resources
  class Indexed  < SimpleDelegator
    WrongEntriesCountError = Class.new StandardError
    NoIdInEntity  = Class.new StandardError

    include WhereFilter
    include LoadAll

    def initialize resource
      raise TypeError, 'resource должен быть Moysklad::Resources::Base' unless resource.is_a? Moysklad::Resources::Base
      super resource
    end

    # Автоматически подгружает постранично данныез из API и возвращает их все сразу.
    #
    # @return [Array of Moysklad::Entities::Base]
    def all
      @cached_list || pull_list
    end

    def cache
      all.count
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
      pull_list unless @_index
      @_index
    end

    def pull_list
      @cached_list = load_all
      @_index = prepare_index @cached_list
      @cached_list
    end

    def prepare_index cached_list
      i={}
      cached_list.each do |r|
        raise NoIdInEntity, "У объекта нет id: #{r}" unless r.respond_to?(:id) && r.id
        i[r.id]=r
      end
      return i
    end
  end
end
