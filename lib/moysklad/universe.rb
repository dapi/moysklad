module Moysklad
  class Universe
    cattr_reader :resources_list
    attr_reader :client

    # @param client[Moysklad::Client]
    def initialize client: nil
      raise "Должен быть client[Moysklad::Client]" unless client.is_a? Moysklad::Client
      @client = client
      @resources={}
    end

    def self.client_class
      Client
    end

    def company_settings_metadata
      @company_settings_metadata ||= Moysklad::Entities::CompanySettingsMetadata.build client.get('context/companysettings/metadata'), self
    end

    # Все элементы всех словарей
    def all_custom_entities
      @all_custom_entities ||= company_settings_metadata.customEntities.map { |d| d.entities(self) }
    end

    # Ленивое создание universe
    #
    # @param login
    # @param password
    def self.build login: nil, password: nil, logger: nil
      new client: client_class.new(login: login, password: password, logger: nil)
    end

    @@resources_list = []
    Moysklad::Resources.resources.each do |resource_klass|
      @@resources_list << resource_klass.pluralized_type.to_sym
      define_method resource_klass.pluralized_type do |opts={}|
        @resources[resource_klass.type] ||= resource_klass.indexed( **opts.merge(client: client) )
      end
    end

    def class_by_resource resource
      "Moysklad::Resources::#{resource.to_s.singularize.capitalize}".constantize
    end
  end
end
