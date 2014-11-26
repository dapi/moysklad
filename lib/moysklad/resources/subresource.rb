require_relative 'where_filter'
module Moysklad::Resources
  class Subresource < Struct.new(:items)
    include WhereFilter

    def find uuid
      findWhere uuid: uuid
    end

    private

    def values
      items
    end

  end
end
