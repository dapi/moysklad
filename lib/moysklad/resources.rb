module Moysklad::Resources
  mattr_accessor :resources

  extend ActiveSupport::Autoload

  def self.register_resource resource_class
    self.resources ||= []
    self.resources << resource_class
  end

  require_relative 'resources/base'
  require_relative 'resources/indexed'
  require_relative 'resources/stock'
  require_relative 'resources/embedded_entity_metadata'
  require_relative 'resources/embedded_entity_metadata_indexed'
  require_relative 'resources/custom_entity_metadata'
  require_relative 'resources/subresource'

  # Простые ресурсы, которые создаются автоматически
  %w{Products Productfolders Uoms PriceType Countries Variants
    CustomEntities CustomerOrders Store
    Assortment
    Workflows
    Companies Consignments MyCompanies}.each do |klass_name|
    const_set klass_name, Class.new( Base )
  end
end
