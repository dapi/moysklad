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

    private

    def parse_collection content
      items = Moysklad::Entities::StockTO.parse content
      Moysklad::Entities::Page.new items, items.count, 0, items.count
    end

  end
end
