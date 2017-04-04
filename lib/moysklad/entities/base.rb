module Moysklad::Entities
  class Base
    include Virtus.model

    def initialize(data)
      super (data || {}).merge(dump: data)
    end

    attribute :dump, Hash

    def to_s
      attributes.to_s
    end
  end
end
