module Moysklad::Entities
  class Base
    include Virtus.model
    attr_accessor :universe
    attr_accessor :dump

    def self.build(data, universe)
      entity = new data
      entity.universe = universe
      entity
    end

    def initialize(data = {})
      super data.merge(dump: data)
    end

    def to_json(*args)
      presented = {}
      to_h.each_pair do |k, v|
        presented[k] = v unless v.nil?
      end

      presented.to_json
    end

    def to_s
      attributes.to_s
    end
  end
end
