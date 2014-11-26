module RspecResourceSupport

  def raw_consignment_0_list
    File.new './spec/fixtures/Consignment_list_0.raw'
  end

  def raw_consignment_1000_list
    File.new './spec/fixtures/Consignment_list_1000.raw'
  end

  def total_consignment_count
    1280
  end

  def feature_list_items_count
    863
  end

  def raw_feature_list
    File.new './spec/fixtures/Feature_list.raw'
  end

  def feature_list_items_count
    863
  end

  def client
    @client ||= Moysklad::Client.new
  end

  def universe
    @universe ||= Moysklad::Universe.new client: client
  end

  def resource_list_url res=nil, start=nil
    res ||= resource
    url = Moysklad::Client::URL + '/' + res.send(:list_path)
    url+="?start=#{start}" if start

    return url
  end

  def consignments_resource
    @consignments_resource ||= Moysklad::Resources::Consignments.new client: client
  end

  def stub_consignments_requests
    stub_request(:get, resource_list_url(consignments_resource, 0)).to_return(raw_consignment_0_list)
    stub_request(:get, resource_list_url(consignments_resource, 1000)).to_return(raw_consignment_1000_list)
  end

end

RSpec.configure do |config|
  config.include RspecResourceSupport
end
