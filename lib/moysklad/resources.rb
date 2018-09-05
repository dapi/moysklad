module Moysklad::Resources
  mattr_accessor :resources

  extend ActiveSupport::Autoload

  def self.register_resource resource_class
    self.resources ||= []
    self.resources << resource_class
  end

  require_relative 'resources/base'
  require_relative 'resources/indexed'
  require_relative 'resources/custom_entities'
  require_relative 'resources/assortments'

  # Простые ресурсы, которые создаются автоматически
  %w{Products Productfolders Uoms PriceType Countries Variants
    Counterparty
    Organization
    Service
    Bundle
    CustomerOrders Store
    Currency
    Workflows
    Companies Consignments MyCompanies Group}.each do |klass_name|
    const_set klass_name, Class.new( Base )
  end
end
