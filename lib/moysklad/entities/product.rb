module Moysklad::Entities
  class Product < Entity
    include AttributesConverter
    attribute :accountId,         String
    attribute :owner,             Owner
    attribute :group,             Group
    attribute :description,       String
    # attribute :shared,            Shared
    attribute :vat, Float
    attribute :effectiveVat, Float
    attribute :pathName,          String
    attribute :productFolder,     Productfolder

    attribute :uom,               Uom

    attribute :minPrice,          Float
    attribute :buyPrice,          Currency
    attribute :salePrices,        Array[Price]

    attribute :image,             Image

    attribute :article,           String
    attribute :weighed,           Boolean
    attribute :attrs,             Array[Attribute]
    attribute :weight,            Float
    attribute :volume,            Float
    attribute :barcodes,          Array[String]

    attribute :isSerialTrackable, Boolean

    attribute :modificationsCount, Integer


    # Когда загружаем через ассортименты эти поля устанавливаются
    attribute :stock, Float
    attribute :reserve, Float
    attribute :inTransit, Float
    attribute :quantity, Float

    # preferences

    def features universe
      cache :features, universe do
        universe.features.where goodUuid: uuid
      end
    end
  end
end
