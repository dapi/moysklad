module Moysklad::Entities
  class Base
    include Virtus.model
    attr_accessor :universe

    def self.build(data, universe)
      entity = new data
      entity.universe = universe
      entity
    end

    def initialize(data)
      data['attrs'] = data.delete 'attributes' if data['attributes']
      super (data || {}).merge(dump: data)
    end

    attribute :dump, Hash

    def to_s
      attributes.to_s
    end
  end
end
