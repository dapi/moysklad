require 'spec_helper'

describe Moysklad::Resources::Indexed do
  let(:raw_response) { File.new './spec/fixtures/Feature_list.raw' }
  let(:items_count)  { 863 }

  let(:client)   { Moysklad::Client.new }
  let(:resource) { Moysklad::Resources::Features.new client: client }

  let(:url) { Moysklad::Client::URL + '/' + resource.send(:list_path) }

  before do
    stub_request(:get, url).to_return(raw_response)
  end

  subject { Moysklad::Resources::Indexed.new resource }

  it 'загружено верное количество данных' do
    expect(subject.all.count).to eq items_count
    expect(subject.send(:index).count).to eq items_count
  end

  describe 'кешированные данные' do
    let(:uuid) { '00e4c547-4ee1-11e4-90a2-8eca00246333' }

    before do
      subject.all
    end

    it 'элемет получаем из кеша' do
      expect(subject.get uuid).to be_a resource.class.entity_class
    end
  end

end

