module Moysklad::Resources
  class Products < Base

    private

    def entity_class
      Moysklad::Entities::Product
    end
  end
end
