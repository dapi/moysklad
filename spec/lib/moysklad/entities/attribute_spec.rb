require 'spec_helper'

describe Moysklad::Entities::Attribute do
  let(:good_uuid) { 'eb77ad57-2e22-11e4-4030-002590a28eca' }

  before do
    stub_rest :Good, good_uuid
    stub_rest :EmbeddedEntityMetadata, :list, 0
    stub_rest :CustomEntity, :list, 0
  end

  let(:goods_resource) { Moysklad::Resources::Goods.indexed client: client }
  let(:good) { goods_resource.get good_uuid }

  let(:attribute_with_id_custom) { good.attributes.first }
  let(:attribute_with_text)      { good.attributes.second }

  it 'should get ' do
    expect(good).to be_a Moysklad::Entities::Good
  end

  describe 'аттрибут типа ID_CUSTOM' do
    subject { attribute_with_id_custom }

    it do
      expect(subject.metadata(universe)).to be_a Moysklad::Entities::AttributeMetadata
      expect(subject.metadata(universe).name).to eq 'Вставки'
      expect(subject.attributeName(universe)).to eq 'Вставки'
    end

    it do
      expect(subject.get_value(universe)).to eq "Культ. жемчуг, куб. циркон"
    end
  end

end
