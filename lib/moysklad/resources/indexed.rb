require_relative 'where_filter'

module Moysklad::Resources
  class Indexed  < SimpleDelegator
    include WhereFilter

    def initialize resource
      raise 'resource должен быть Moysklad::Resources::Base' unless resource.is_a? Moysklad::Resources::Base
      super resource
    end

    # Автоматически подгружает постранично данныез из API и возвращает их все сразу.
    #
    # @return [Array of Moysklad::Entities::Base]
    def all
      @cached_list || pull_list
    end

    # Возвращает запрашивемую запись из кеша.
    # Предварительно подгружает все записи через метод `all`
    #
    # @return Moyskald::Entities::Base
    def find uuid
      index[uuid]
    end

    # Перечень uuid-ов всех элементов в ресуресе
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
      @cached_list = load_full_list
      @_index = prepare_index @cached_list
      @cached_list
    end

    def load_full_list
      start = 0
      list = []

      _page = nil

      begin
        _page = page start: start
        list += _page.items
        break if _page.items.empty?
        start = list.count
      end while start<_page.total

      raise "При загрузке коллекции в результате колиество не совпадает с total: #{list.count}<>#{_page.total}" unless list.count==_page.total

      list
    end

    def prepare_index cached_list
      i={}
      cached_list.each do |r|
        raise "У объекта нет uuid: #{r.to_xml}" unless r.respond_to?(:uuid) && r.uuid
        i[r.uuid]=r
      end
      return i
    end

  end
end
