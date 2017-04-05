module Moysklad
  module Entities
    extend ActiveSupport::Autoload
    %w{
      AttachmentDocument
      Uom
      Productfolder
      Product
      Barcode
      Error
      Consignment
      MyCompany
      Attribute
      GoodRef
      Base
      CustomerOrder
      CustomEntity
      Variant
      AttributeMetadata
      EmbeddedEntityMetadata
      CompanySettingsMetadata
      Price
      Currency
      Company
      Store
      Service
      Owner
      Group
      Collection
      Page
      ResourceMetadata
      Attribute
      Characteristic
    }.each do |m|
      autoload m
    end
  end
end
