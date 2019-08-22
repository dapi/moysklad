module Moysklad::Resources
  mattr_accessor :resources

  def self.register_resource resource_class
    self.resources ||= []
    self.resources << resource_class
  end

  %w{
    positions
    base
    load_all
    assortments
    custom_entities
    custom_entity_metadata
    embedded_entity_metadata
    where_filter
    indexed_cache
    indexed
    embedded_entity_metadata_indexed
    products
    stock
    subresource
  }.each do |m|
    require_relative "resources/#{m}"
  end

  # Простые ресурсы, которые создаются автоматически
  %w{Productfolders Uoms PriceType Countries Variants
    Counterparty
    Organization
    Service
    Bundle
    CustomerOrders Store
    Currency
    Consignments Group}.each do |klass_name|
    const_set klass_name, Class.new( Base )
  end
end
