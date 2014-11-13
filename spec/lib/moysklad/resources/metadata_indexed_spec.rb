require 'spec_helper'

describe Moysklad::Resources::MetadataIndexed do

  let(:raw_response) { File.new './spec/fixtures/Metadata_list.raw' }
  let(:article_uuid) { 'dc410ce3-505a-11e4-90a2-8eca00496371' }

  before do
    stub_request(:get, "https://online.moysklad.ru/exchange/rest/ms/xml/Metadata/list?start=0").to_return(raw_response)
  end

  describe 'subresource' do
    subject { Moysklad::Resources::Metadata.indexed client: client }
    it 'should get list' do
      expect(subject.subresource_by_name(:GoodFolder, article_uuid)).to be_a Moysklad::Entities::AttributeMetadata
    end
  end

end


