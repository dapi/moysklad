require_relative 'employee'

module Moysklad::Entities
  class Context
    include Virtus.model

    attribute :employee, Employee
  end
end
