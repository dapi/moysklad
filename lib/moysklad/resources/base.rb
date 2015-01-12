class Moysklad::Resources::Base
  PREFIX_PATH = 'exchange/rest/ms/xml/'

  def self.inherited superclass 
    super
    Moysklad::Resources.register_resource superclass
  end

  # Возвращает этот-же ресурс только индексированный
  #
  # @return [Moysklad::Resources::Indexed]
  def self.indexed *args
    Moysklad::Resources::Indexed.new new(*args)
  end

  # https://support.moysklad.ru/hc/ru/articles/203404253-REST-сервис-синхронизации-данных
  def initialize client: nil
    raise "Должен быть Moysklad::Client" unless client.is_a? Moysklad::Client
    @client = client
  end

  # Возвращает список элементов как есть
  #
  # @return [Array of Moysklad::Entities::Base]
  def list params={}
    parse client.get list_path, params
  end

  # Возвращает страницу со списком элементов
  #
  # @return [Moysklad::Entities::Page]
  def page params={}
    parse_page client.get list_path, params
  end

  # Забираем элемент по uuid
  #
  # @return [Moysklad::Entities::Base]
  def get uuid
    parse client.get item_path uuid
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
    parse client.put create_path, prepare_resource(model)
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

  def self.entity_class
    ActiveSupport::Inflector.constantize "Moysklad::Entities::#{type.to_s}"
  end

  private

  attr_reader :client

  def prepare_resource resource
    if resource.is_a? Moysklad::Entities::Base
      resource.to_xml.to_s
    else
      resource.to_s
    end
  end

  def parse content
    self.class.entity_class.parse parse_content content
  end

  def parse_content content
    Nokogiri::XML content
  end

  def parse_page content
    col = Moysklad::Entities::Collection.parse parse_content content

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
