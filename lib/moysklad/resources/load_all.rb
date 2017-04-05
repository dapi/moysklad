module Moysklad::Resources
  module LoadAll
    def load_all(params = {})
      limit = 100
      offset = 0
      rows = []
      collection = nil

      begin
        collection = list params.merge(limit: limit, offset: offset)
        rows += collection.rows
        break if collection.rows.empty?
        offset = rows.count
      end while offset<collection.meta.size

      raise WrongEntriesCountError, "При загрузке коллекции в результате колиество не совпадает с total: #{rows.count}<>#{collection.meta.size}" unless rows.count==collection.meta.size

      rows
    end
  end
end
