class Moysklad::Resources::Cached < SimpleDelegator
  def list filters={}
    if filters.empty?
      cached_list || pull_lisl
    else
      pull_list(filters)
    end
  end

  private

  def cached_list
    nil
  end

  def pull_list filters
    @cached_list = __getobj__.list( filters )
    @index = {}
    @cached_list.each do |o|
      raise "В индексе уже существует элемент с таким uuid: #{o.uuid}" if @index.incude? o.uuid
      @index[o.uuid]=o
    end
    @index
  end
end
