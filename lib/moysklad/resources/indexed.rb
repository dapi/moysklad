class Moysklad::Resources::Indexed < SimpleDelegator

  def preload!
    all
  end

  def all
    list
  end

  def list filters={}
    if filters.empty?
      if @index_loaded
        @index
      else
        pull_indexed
      end
    else
      pull_list filters
    end
  end

  def find uuid
    if @index && @index.include?(uuid)
      @index[uuid]
    else
      @index[uuid]=__getobj__.get(uuid)
    end
  end

  private

  def pull_list filters={}
     __getobj__.list filters
  end

  def pull_indexed
    list = pull_list
    @index = {}
    list.each do |o|
      raise "В индексе уже существует элемент с таким uuid: #{o.uuid}" if @index.include? o.uuid
      @index[o.uuid]=o
    end
    @index_loaded = true
    @index.values
  end
end
