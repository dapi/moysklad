module Moysklad::Entities
  class CollectionMeta < Meta
    # Следующие атрибуты объекта meta появляются, как правило, в методах выдачи списка сущностей/строк отчёта
    attribute :size, Integer
    attribute :limit, Integer
    attribute :offset, Integer

    attribute :nextHref, String
    attribute :prevHref, String
  end
end
