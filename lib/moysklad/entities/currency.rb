require_relative 'meta'

module Moysklad::Entities
  class Currency < Base
    class Unit < Base
      attribute :gender, String
      attribute :s1, String
      attribute :s2, String
      attribute :s5, String
    end
    attribute :meta, Meta
    attribute :system, Boolean
    attribute :name, String
    attribute :fullName, String
    attribute :rate, Float
    attribute :multiplicity, Integer
    attribute :rateUpdateType, String
    attribute :code, String
    attribute :isoCode, String
    attribute :majorUnit, Unit
    attribute :minorUnit, Unit
    attribute :archived, Boolean
    attribute :default, Boolean

    def id
      meta.href.split('/').last
    end
  end
end
