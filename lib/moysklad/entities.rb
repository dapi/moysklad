module Moysklad
  module Entities
    extend ActiveSupport::Autoload

    autoload :XmlFix
    autoload :CommonObject
    autoload :CompanyConcern
    autoload :Common

    %w{
      Slot
      Contact
      GoodFolder
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
      CustomEntity
      CustomEntityMetadata
      Feature
      AttributeMetadata
      EmbeddedEntityMetadata
      Price
      StockTO
      Company
      Warehouse
      Collection
      CustomEntity
      Page
    }.each do |m|
      autoload m
    end
  end

end
