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
      method_name = ActiveSupport::Inflector.underscore ActiveSupport::Inflector.pluralize(resource_klass.type)
      define_method method_name do
        @resources[resource_klass.type] ||= resource_klass.new( client: client )
      end
    end

    private

    attr_reader :client
    
    def available_resources
      [:features, :consignments]
    end

  end

end
