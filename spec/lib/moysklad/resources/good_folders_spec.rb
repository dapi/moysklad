require 'spec_helper'

describe Moysklad::Resources::GoodFolders do

  it 'should be GoodFolder' do
    expect(described_class.entity_class).to eq Moysklad::Entities::GoodFolder
  end

  describe 'resource' do
    subject { Moysklad::Resources::GoodFolders.new client: client }

    it 'should get item' do
      expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/Goods/list"
    end
  end

end
