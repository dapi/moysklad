module Moysklad::Entities
  class Entity < Base

    # product, productfolder, feature
    #meta - Метаданные объекта
    #id - ID услуги в формате UUID Только для чтения
    #accountId - ID учетной записи Только для чтения
    #version - Версия сущности Только для чтения
    #updated - Момент последнего обновления сущности Только для чтения
    #name - Наименование товара с Модификацией
    #code - Код Модификации
    #externalCode - Внешний код Модификации
    #archived - Добавлен ли товар в архив

    attribute :meta, Meta
    attribute :id,                String
    attribute :version,           Integer
    attribute :updated,           String
    attribute :name,              String
    attribute :code,              String
    attribute :externalCode,      String
    attribute :archived,          Boolean

    def to_s
      attributes.to_s
    end

    private

    def cache ns, key
      @cache||={}
      @cache[ns]||={}
      cc = @cache[ns]

      cc[key] = yield unless cc.has_key? key
      cc[key]
    end
  end
end
