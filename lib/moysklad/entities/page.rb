module Moysklad::Entities
  class Page < Struct.new(:items, :total, :start, :count)

  end
end
