module Moysklad::Resources
  mattr_accessor :resources

  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Cached
  autoload :Indexed
  autoload :Stock

  def self.register_resource resource_class
    self.resources ||= []
    self.resources << resource_class
  end

  class Metadata < Base
    def self.entity_class
      Moysklad::Entities::EmbeddedEntityMetadata
    end
  end

  # Простые ресурсы
  %w{Goods Features CustomerOrders Warehouses Attributes Companies Consignments MyCompanies}.each do |klass_name|
    const_set klass_name, Class.new( Base )
  end

end
