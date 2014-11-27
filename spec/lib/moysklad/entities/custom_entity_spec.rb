require 'spec_helper'

describe Moysklad::Entities::CustomEntity do

  before do
    stub_rest :CustomEntityMetadata, :list, 0
    stub_rest :CustomEntity, :list, 0
  end

  let(:resource) { Moysklad::Resources::CustomEntities.indexed client: client }

  describe do
    let(:custom_entity) { resource.all.first }

    subject { custom_entity }

    it do
      expect(subject).to be_a Moysklad::Entities::CustomEntity
    end

    it 'unicoded xml' do
      expect(subject.to_xml).to start_with '<?xml version="1.0" encoding="utf-8"?>'
    end

    context 'entityMetadata' do

      it do
        expect(subject.entityMetadata(universe)).to be_a Moysklad::Entities::CustomEntityMetadata
      end

    end

  end
end

