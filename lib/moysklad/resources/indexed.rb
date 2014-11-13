class Moysklad::Resources::Indexed  < SimpleDelegator

  def initialize resource
    raise 'resource должен быть Moysklad::Resources::Base' unless resource.is_a? Moysklad::Resources::Base
    super resource
  end

  def all
    @cached_list || pull_list
  end

  def get uuid
    index[uuid]
  end

  def uuids
    index.keys
  end

  def resource
    __getobj__
  end

  private

  def index
    pull_list unless @_index
    @_index
  end

  def pull_list 
    @cached_list = load_full_list
    @_index = prepare_index @cached_list
    @cached_list
  end

  def load_full_list
    start = 0
    list = []

    page = nil

    begin
      page = collection start: start
      list += page.items
      break if page.items.empty?
      start = list.count
    end while start<page.total

    raise "При загрузке коллекции в результате колиество не совпадает с total: #{list.count}<>#{page.total}" unless list.count==page.total

    list
  end

  def prepare_index cached_list
    i={}
    cached_list.each do |r|
      raise "У объекта нет uuid: #{r.to_xml}" unless r.respond_to?(:uuid) && r.uuid
      i[r.uuid]=r
    end
    return i
  end

end
