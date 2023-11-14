# Элемент в справочнике (DictionaryEntity)
module Moysklad::Entities
  class CustomEntity < Base
    attribute :meta,         Meta
    attribute :accountId,    String
    attribute :id,           String
    attribute :name,         String
    attribute :externalCode, String
    attribute :description,  String

    # ID Словаря
    def dictionaryId
      meta.metadataHref.split('/').last
    end

    def to_s
      name
    end
  end
end
