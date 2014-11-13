class Moysklad::Resources::Base
  PREFIX_PATH = 'exchange/rest/ms/xml/'

  def self.inherited superclass
    super
    Moysklad::Resources.register_resource superclass
  end

  # https://support.moysklad.ru/hc/ru/articles/203404253-REST-сервис-синхронизации-данных
  def initialize client: nil
    raise "Должен быть Moysklad::Client" unless client.is_a? Moysklad::Client
    @client = client
  end

  def list params={}
    parse client.get list_path, params
  end

  def collection params={}
    parse_collection client.get list_path, params
  end

  def find uuid
    parse client.get item_path uuid
  end

  def create resource
    parse client.put create_path, prepare_resource(resource)
  end

  def delete uuid
    client.delete item_path uuid 
  end

  def self.type
    ActiveSupport::Inflector.singularize name.split('::').last.to_sym
  end

  def self.pluralized_type
    ActiveSupport::Inflector.underscore ActiveSupport::Inflector.pluralize type
  end

  def self.entity_class
    ActiveSupport::Inflector.constantize "Moysklad::Entities::#{type.to_s}"
  end
  private

  attr_reader :client

  def prepare_resource resource
    resource
  end

  def parse content
    self.class.entity_class.parse content
  end

  def parse_collection content
    col = Moysklad::Entities::Collection.parse content

    # TODO Парсится два раза. Оптимизировать. Например сделать динамические CollectionFeature 
    # и парсить через них

    items = parse content
    Moysklad::Entities::Page.new items, col.total,  col.start, col.count
  end

  def item_path uuid
    prefix_path + '/' + uuid
  end

  def create_path
    prefix_path
  end

  def list_path
    prefix_path + '/list'
  end

  def prefix_path
    PREFIX_PATH + self.class.type
  end

end
