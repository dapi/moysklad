require 'spec_helper'

describe Moysklad::Entities::Good do
  let(:good_uuid) { 'eb77ad57-2e22-11e4-4030-002590a28eca' }

  let(:raw_response) { File.new "./spec/fixtures/Good_#{good_uuid}.raw" }
  let(:raw_features_list_response) { File.new "./spec/fixtures/Feature_list.raw" }

  before do
    stub_request(:get, "https://online.moysklad.ru/exchange/rest/ms/xml/Good/#{good_uuid}").to_return(raw_response)
    stub_request(:get, "https://online.moysklad.ru/exchange/rest/ms/xml/Feature/list?start=0").to_return(raw_features_list_response)
  end

  let(:goods_resource) { Moysklad::Resources::Goods.indexed client: client }
  let(:good) { goods_resource.get good_uuid }

  describe 'features' do
    let(:features) { good.features universe }

    it do
      expect(features).to be_a Array
      expect(features.count).to eq 3
    end

    context do
      subject { features.first }
      it do
        expect(subject).to be_a Moysklad::Entities::Feature
      end
    end
  end

  describe 'attribute' do
    it do
      expect(good.attributes).to be_a Array
      expect(good.attributes.first).to be_a Moysklad::Entities::Attribute
    end
  end

end
