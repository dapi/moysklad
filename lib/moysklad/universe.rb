module Moysklad
  class Universe
    AVAILABLE_RESOURCES = [:features, :consignments, :stock]

    def class_by_resource resource
      "Moysklad::Resources::#{resource.to_s.singularize.capitalize}".constantize
    end

    def initialize client: nil
      @client = client
      @resources={}
    end

    AVAILABLE_RESOURCES.each do |resource|
      define_method resource do
        @resources[resource] ||= self.class_by_resource(resource).new( client: client )
      end
    end

    private

    attr_reader :client
    
    def available_resources
      [:features, :consignments]
    end

  end

end
