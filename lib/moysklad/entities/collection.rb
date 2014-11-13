module Moysklad::Entities
  class Collection < Base
    # Типовое количество элементов которое возвращает мойсклад
    DEFAULT_COUNT = 1000
    include HappyMapper

    attribute :total, Integer
    attribute :start, Integer
    attribute :count, Integer

    #has_many :consignment, Consignment, read_only: true
    #has_many :feature,     Feature,     read_only: true

  end
end
