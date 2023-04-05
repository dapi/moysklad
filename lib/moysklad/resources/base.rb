class Moysklad::Resources::Base
  include Moysklad::Resources::Positions

  PREFIX_PATH = 'entity/'

  def self.inherited superclass
    super
    Moysklad::Resources.register_resource superclass
  end

  # Возвращает этот-же ресурс только индексированный
  #
  # @return [Moysklad::Resources::Indexed]
  def self.indexed client: nil, list_path: nil
    Moysklad::Resources::Indexed.new new(client: client, list_path: list_path)
  end

  # https://support.moysklad.ru/hc/ru/articles/203404253-REST-сервис-синхронизации-данных
  def initialize client: nil, list_path: nil
    @list_path = list_path
    raise "Должен быть Moysklad::Client" unless client.is_a? Moysklad::Client
    @client = client
  end

  def metadata
    Moysklad::Entities::ResourceMetadata.build client.get(metadata_path), self
  end

  # Возвращает список элементов как есть
  #
  # @return [Array of Moysklad::Entities::Base]
  def list params={}
    load_collection client.get list_path, params
  end

  # Забираем элемент по uuid
  #
  # @return [Moysklad::Entities::Base]
  def get uuid, params = {}
    parse_get client.get item_path(uuid), params
  end

  # Модифицируем элемент по uuid
  #
  # @return [Moysklad::Entities::Base]
  def update model
    create model
  end

  # Создаем запись
  #
  # @param [Moysklad::Entities::Base]
  #
  # Возвращается созданная на сервере сущность
  #
  # @return [Moysklad::Entities::Base]
  def create model
    raise "Должна быть модель типа Moysklad::Entities::Base" unless model.is_a? Moysklad::Entities::Base
    parse_get client.post create_path, model.to_json
  end

  # Удаляем запись по uuid
  #
  # @param uuid
  def delete uuid
    client.delete item_path uuid
  end

  def self.type
    ActiveSupport::Inflector.singularize name.split('::').last.to_sym
  end

  def self.pluralized_type
    ActiveSupport::Inflector.underscore ActiveSupport::Inflector.pluralize type
  end

  private

  attr_reader :client

  def parse_get data
    entity_class.build data, self
  end

  def load_collection data
    collection_class.build data, self
  end

  def item_path uuid
    prefix_path + '/' + uuid
  end

  def create_path
    prefix_path
  end

  def list_path
    @list_path ||= prefix_path
  end

  def metadata_path
    prefix_path + '/metadata'
  end

  def collection_class
    Moysklad::Entities::Collection
  end

  def entity_class
    ActiveSupport::Inflector.constantize "Moysklad::Entities::#{self.class.type.to_s}"
  end

  def prefix_path
    PREFIX_PATH + self.class.type.downcase
  end
end
