require_relative 'meta'

module Moysklad::Entities
  class Group < Base
    attribute :meta, Meta
    attribute :name, String

    def id
      URI.parse(meta['href']).path.split('/').last
    end
  end
end
