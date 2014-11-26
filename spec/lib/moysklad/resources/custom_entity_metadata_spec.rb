require 'spec_helper'

describe Moysklad::Resources::CustomEntityMetadata do

  describe do
    subject { described_class.new client: client }
    it 'should get list' do
      expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/CustomEntityMetadata/list"
    end
  end

end

