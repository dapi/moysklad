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
    @cached_list = list
    @_index={}
    @cached_list.each do |r|
      raise "У объекта нет uuid: #{r.to_xml}" unless r.respond_to?(:uuid) && r.uuid
      @_index[r.uuid]=r
    end

    @cached_list
  end

end
