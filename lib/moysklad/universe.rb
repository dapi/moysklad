module Moysklad
  class Universe
    cattr_reader :resources_list

    def class_by_resource resource
      "Moysklad::Resources::#{resource.to_s.singularize.capitalize}".constantize
    end

    def initialize client: nil
      raise "Должен быть client[Moysklad::Client]" unless client.is_a? Moysklad::Client
      @client = client
      @resources={}
    end

    @@resources_list = []
    Moysklad::Resources.resources.each do |resource_klass|
      @@resources_list << resource_klass.pluralized_type.to_sym
      define_method resource_klass.pluralized_type do
        @resources[resource_klass.type] ||= resource_klass.indexed( client: client )
      end
    end

    private

    attr_reader :client
    
  end

end
