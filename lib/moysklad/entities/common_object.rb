module Moysklad::Entities::CommonObject
  extend ActiveSupport::Concern

  # Используется в Good
  # https://online.moysklad.ru/exchange/rest/ms/xml/Good/list
  #
  # В Metadata
  # https://online.moysklad.ru/exchange/rest/ms/xml/Metadata/list
  #
  # Во Feature
  # https://online.moysklad.ru/exchange/rest/ms/xml/Feature/list
  #
  # CustomerOrder
  # https://online.moysklad.ru/exchange/rest/ms/xml/CustomerOrder/list
  #
  included do
    include Moysklad::Entities::Common

    attribute :updated,     Time
    attribute :updatedBy,   String

    attribute :name,        String

    element :externalcode,  String
    element :description,   String
  end

end

