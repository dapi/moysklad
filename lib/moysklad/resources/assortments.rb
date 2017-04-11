require_relative 'load_all'
module Moysklad::Resources
  class Assortments < Base
    include LoadAll

    def self.indexed(*args)
      new(*args)
    end

    def all(params = {})
      load_all(params)
    end
  end
end
