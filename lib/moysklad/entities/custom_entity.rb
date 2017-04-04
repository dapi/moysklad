require_relative 'meta'

module Moysklad::Entities
  class CustomEntity < Base
    attribute :meta, Meta
    attribute :name, String

    def to_s
      name
    end
  end
end
