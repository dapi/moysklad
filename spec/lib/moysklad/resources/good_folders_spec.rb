require 'spec_helper'

describe Moysklad::Resources::GoodFolders do
  it 'should be loaded' do
    expect(Moysklad::Resources::GoodFolders).to be_a Class
  end

  describe do
    subject { Moysklad::Resources::GoodFolders.new client: client }
    it 'should get list' do
      expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/Goods/list"
    end
  end

end

