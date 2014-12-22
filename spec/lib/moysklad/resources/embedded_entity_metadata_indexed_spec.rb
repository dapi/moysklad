require 'spec_helper'

describe Moysklad::Resources::EmbeddedEntityMetadataIndexed do

  let(:article_uuid) { 'dc410ce3-505a-11e4-90a2-8eca00496371' }

  before do
    stub_rest :EmbeddedEntityMetadata, :list, 0
  end

  describe 'subresource' do
    let(:metadata_resource) { Moysklad::Resources::EmbeddedEntityMetadata.indexed client: client }
    subject { metadata_resource.subresource_by_name :GoodFolder }

    it { expect(subject).to be_a Moysklad::Resources::Subresource }
    it { expect(subject.items.first).to be_a Moysklad::Entities::AttributeMetadata }

  end

end
