require 'spec_helper'

describe Moysklad::Universe do
  let!(:client) { Moysklad::Client.new }

  subject { described_class.new client: client }

  it 'should have a features resoruce' do
      expect(subject.features).to be_a Moysklad::Resources::Indexed
  end

  it do
    expect(subject.embedded_entity_metadata.resource).to be_a Moysklad::Resources::EmbeddedEntityMetadata
  end

  it do 
    expect(subject.resources_list).to have_at_least(10).items
  end

  it do
    expect(subject.resources_list).to include(:features)
  end

  describe '.build' do
    let(:login)    { 'alala' }
    let(:password) { 'ulala' }

    subject { described_class.build login: login, password: password }

    it do
      expect(subject).to be_a Moysklad::Universe
    end

    it do
      expect(subject.client).to be_a Moysklad::Client
    end

  end

  describe do
    before do
      stub_rest :CustomEntityMetadata, :list, 0, './spec/fixtures/resource_forbidden.raw'
    end
    it do
      expect{subject.custom_entity_metadata.all}.to raise_error Moysklad::Client::ResourceForbidden
    end
  end

end
