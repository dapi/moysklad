require 'spec_helper'

describe Moysklad::Resources::EmbeddedEntityMetadata do
  describe do
    subject { described_class.new client: client }
    it 'should get list' do
      expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/EmbeddedEntityMetadata/list"
    end
  end

end
