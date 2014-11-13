module Moysklad
  module Entities
    extend ActiveSupport::Autoload

    autoload :XmlFix
    autoload :CommonObject
    autoload :CompanyConcern
    autoload :Common

    %w{
      Good
      Barcode
      SalePrices
      SalePrice
      Error
      CustomerOrderPosition
      Consignment
      MyCompany
      Attribute
      GoodRef
      Base
      CustomerOrder
      Feature
      AttributeMetadata
      EmbeddedEntityMetadata
      Price
      StockTO
      Company
      Warehouse
      Collection
      Page
    }.each do |m|
      autoload m
    end
  end

end
