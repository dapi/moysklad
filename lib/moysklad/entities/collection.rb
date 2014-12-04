module Moysklad::Entities
  class Collection < Base
    # Типовое количество элементов которое возвращает мойсклад
    DEFAULT_COUNT = 1000
    include HappyMapper

    attribute :total, Integer
    attribute :start, Integer
    attribute :count, Integer

  end
end
