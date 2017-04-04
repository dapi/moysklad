require_relative 'meta'

module Moysklad::Entities
  class Group < Base
    attribute :meta, Meta
  end
end
