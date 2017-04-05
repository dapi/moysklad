require_relative 'meta'

module Moysklad::Entities
  class Shortcut < Base
    attribute :meta, Meta

    def id
      meta.id
    end
  end
end
