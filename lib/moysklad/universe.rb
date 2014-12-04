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

    # Ленивое создание universe
    #
    # @param login
    # @param password
    def self.build login: nil, password: nil
      new client: client_class.new(login: login, password: password)
    end

    @@resources_list = []
    Moysklad::Resources.resources.each do |resource_klass|
      @@resources_list << resource_klass.pluralized_type.to_sym
      define_method resource_klass.pluralized_type do
        @resources[resource_klass.type] ||= resource_klass.indexed( client: client )
      end
    end

    def class_by_resource resource
      "Moysklad::Resources::#{resource.to_s.singularize.capitalize}".constantize
    end

  end

end
