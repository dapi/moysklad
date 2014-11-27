require 'spec_helper'

describe Moysklad::Entities::CustomEntityMetadata do
  let(:raw_response) { File.new "./spec/fixtures/CustomEntityMetadata_list.raw" }

  before do
    stub_rest :CustomEntityMetadata, :list, 0
    stub_rest :CustomEntity, :list, 0
  end

  let(:resource) { Moysklad::Resources::CustomEntityMetadata.indexed client: client }

  describe do
    let(:custom_entity_metadata) { resource.all.first }

    subject { custom_entity_metadata }

    it do
      expect(subject).to be_a Moysklad::Entities::CustomEntityMetadata
    end

    it 'unicoded xml' do
      expect(subject.to_xml).to start_with '<?xml version="1.0" encoding="utf-8"?>'
    end

    context 'entities' do

      it do
        expect(subject.entities(universe)).to be_a Array
        expect(subject.entities(universe).first).to be_a Moysklad::Entities::CustomEntity
      end

    end

  end
end
