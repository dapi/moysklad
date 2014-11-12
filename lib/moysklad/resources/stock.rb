module Moysklad::Resources
  class Stock < Base

    def listWithConsignments params={}
      list params.merge(showConsignments: true)
    end

    def find
      raise 'no such method'
    end

    def list_path
      'exchange/rest/stock/xml'
    end

    def self.entity_class
      Moysklad::Entities::StockTO
    end

    def self.pluralized_type
      :stock
    end
  end
end
