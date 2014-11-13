module Moysklad
  class Universe
    def class_by_resource resource
      "Moysklad::Resources::#{resource.to_s.singularize.capitalize}".constantize
    end

    def initialize client: nil
      raise "Должен быть client[Moysklad::Client]" unless client.is_a? Moysklad::Client
      @client = client
      @resources={}
    end

    Moysklad::Resources.resources.each do |resource_klass|
      define_method resource_klass.pluralized_type do
        @resources[resource_klass.type] ||= resource_klass.indexed( client: client )
      end
    end

    private

    attr_reader :client
    
  end

end
