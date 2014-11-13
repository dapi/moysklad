require 'spec_helper'

describe Moysklad::Resources::Base do
  it 'should be loaded' do
    expect(Moysklad::Resources::Base).to be_a Class
  end

  describe 'правильно определяет название модели' do
    let!(:entity_class) { Moysklad::Entities::Computer = Class.new }
    subject { Moysklad::Resources::Computers = Class.new Moysklad::Resources::Base }

    it do
      expect(subject.entity_class).to eq entity_class
    end
  end

  describe 'collection' do
    let(:raw_response) { raw_feature_list }
    let(:resource) { Moysklad::Resources::Features.new client: client }
    let(:url) { resource_list_url }

    before do
      stub_request(:get, url).to_return(raw_response)
    end

    subject { resource.collection }

    it do
      expect(subject.total).to eq feature_list_items_count
      expect(subject.count).to eq Moysklad::Entities::Collection::DEFAULT_COUNT
      expect(subject.start).to eq 0
      expect(subject.items.count).to eq feature_list_items_count
    end

  end
end
