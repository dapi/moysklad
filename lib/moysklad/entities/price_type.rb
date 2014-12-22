module Moysklad::Entities
  class PriceType < Base
    include CommonObject
    include Moysklad::Entities::XmlFix

    attribute :updated,     Time
    attribute :updatedBy,   String
    attribute :name,        String

    attribute :index,       Integer
  end
end
