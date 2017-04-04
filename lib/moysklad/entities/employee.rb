require_relative 'meta'

module Moysklad::Entities
  class Employee < Base
    attribute :meta, Meta
  end
end
