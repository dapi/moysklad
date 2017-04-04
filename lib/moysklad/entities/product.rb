require_relative 'currency'
require_relative 'productfolder'
require_relative 'uom'
require_relative 'entity'
require_relative 'attribute_metadata'
require_relative 'attributes_support'

module Moysklad::Entities
  class Product < Entity
    include AttributesSupport

    attribute :accountId,         String
    attribute :owner,             Owner
    attribute :group,             Group
    attribute :description,       Boolean
    # attribute :shared,            Shared
    attribute :vat, Float
    attribute :effectiveVat, Float
    attribute :pathName,          String
    attribute :productFolder,     Productfolder

    # attribute :uom,               Uom

    attribute :minPrice,          Float
    attribute :salePrice,         Float
    attribute :buyPrice,          Currency
    attribute :salePrices,        Array[Price]

    attribute :article,           String
    attribute :weighed,           Boolean
    attribute :attrs,             Array[Attribute]
    attribute :weight,            Float
    attribute :volume,            Float
    attribute :barcodes,          Array[String]

    attribute :isSerialTrackable, Boolean

    attribute :modificationsCount, Integer

    # preferences

    def features universe
      cache :features, universe do
        universe.features.where goodUuid: uuid
      end
    end
  end
end
