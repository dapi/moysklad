require 'spec_helper'

describe Moysklad::Resources::Metadata do
  it 'should be loaded' do
    expect(Moysklad::Resources::Metadata).to be_a Class
  end

  describe do
    subject { Moysklad::Resources::Metadata.new client: client }
    it 'should get list' do
      expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/Metadata/list"
    end
  end

end
