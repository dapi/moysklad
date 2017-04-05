require_relative 'characteristic'
require_relative 'shortcut'
require_relative 'entity'

module Moysklad::Entities
  class Variant < Entity

    attribute :accountId,                String

    attribute :characteristics, Array[Characteristic]
    attribute :minPrice, Float
    attribute :buyPrice, Float
    attribute :salePrices, Array[Price]
    attribute :product, Shortcut
    attribute :things, Array[String]

    # Когда загружаем через ассортименты эти поля устанавливаются
    attribute :stock, Float
    attribute :reserve, Float
    attribute :inTransit, Float
    attribute :quantity, Float

#characteristics - Характеристики Модификации Необходимое
#minPrice - Минимальная цена
#buyPrice - Закупочная цена
#salePrices - Цены продажи
#product - Метаданные, представляющие с собой ссылку на товар, к которому привязана Модификация. Необходимое
#things - Серийные номера Только для чтения

    #attribute :charactideristics,
      #attribute :minPrice

    #tag 'feature'

    #attribute :goodUuid,    String

    #attribute :archived,    Boolean
    #attribute :isDefault,   Boolean

    #element   :shared,      Boolean

    #has_many  :attributes,  Moysklad::Entities::Attribute
    #has_many  :barcodes,    Moysklad::Entities::Barcode

    #def good universe
      #cache :good, universe do
        #universe.good.find goodUuid
      #end
    #end
  end
end
