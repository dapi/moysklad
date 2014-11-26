module Moysklad::Resources::WhereFilter
  def where filter
    values.select { |v| filtered? v, filter }
  end

  def findWhere filter
    where(filter).first
  end

  private

  def filtered? o, filter={}
    filter.select { |k,v| o.send(k)==v }.count == filter.keys.count
  end

end
