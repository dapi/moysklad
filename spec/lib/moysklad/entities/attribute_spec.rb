require 'spec_helper'

describe Moysklad::Entities::Attribute do
  let(:good_uuid) { 'eb77ad57-2e22-11e4-4030-002590a28eca' }

  let(:raw_response) { File.new "./spec/fixtures/Good_#{good_uuid}.raw" }
  let(:raw_metadata_response) { File.new './spec/fixtures/Metadata_list.raw' }
  let(:raw_custom_entity_list_response) { File.new './spec/fixtures/CustomEntity_list.raw' }

  before do
    stub_request(:get, "https://online.moysklad.ru/exchange/rest/ms/xml/Good/#{good_uuid}").to_return(raw_response)
    stub_request(:get, "https://online.moysklad.ru/exchange/rest/ms/xml/Metadata/list?start=0").to_return(raw_metadata_response)
    stub_request(:get, "https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntity/list?start=0").to_return(raw_custom_entity_list_response)
  end

  let(:goods_resource) { Moysklad::Resources::Goods.indexed client: client }
  let(:good) { goods_resource.get good_uuid }

  let(:attribute_with_id_custom) { good.attributes.first }
  let(:attribute_with_text)      { good.attributes.second }

  it 'should get ' do
    expect(good).to be_a Moysklad::Entities::Good
  end

  describe 'аттрибут типа ID_CUSTOM' do
    subject { attribute_with_id_custom }

    it do
      expect(subject.attributeMetadata(universe)).to be_a Moysklad::Entities::AttributeMetadata
      expect(subject.attributeMetadata(universe).name).to eq 'Вставки'
    end

    it do
      expect(subject.get_value(universe)).to eq "Культ. жемчуг, куб. циркон"
    end
  end

end

