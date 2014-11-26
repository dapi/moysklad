require 'spec_helper'

describe Moysklad::Entities::AttributeMetadata do
  let(:metadata_resource) { Moysklad::Resources::Metadata.indexed client: client }
  let(:subresource) {  metadata_resource.subresource_by_name :GoodFolder }
  let(:attribute_metadata) { subresource.items.first }

  before do
    stub_rest :Metadata, :list, 0
    stub_rest :CustomEntityMetadata, :list, 0
  end

  context do
    subject { attribute_metadata.dictionatyMetadata universe }
    it do
      expect(subject).to be_a Moysklad::Entities::CustomEntityMetadata
      expect(subject.uuid).to eq attribute_metadata.dictionaryMetadataUuid
    end
  end

  context do
    subject { attribute_metadata.entityMetadata universe }

    it do
      expect(subject).to be_a Moysklad::Entities::EmbeddedEntityMetadata
      expect(subject.uuid).to eq attribute_metadata.entityMetadataUuid
    end
  end
end

