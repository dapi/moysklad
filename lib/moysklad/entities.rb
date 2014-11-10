module Moysklad
  module Entities
    extend ActiveSupport::Autoload

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
      EmbeddedEntityMetadata
      Price
      StockTO
      Company
      Warehouse
    }.each do |m|
      autoload m
    end
  end

end
