require 'spec_helper'

describe Moysklad::Universe do
  let!(:client) { Moysklad::Client.new }

  subject { described_class.new client: client }

  it 'should have a features resoruce' do
      expect(subject.features).to be_a Moysklad::Resources::Indexed
  end

  it do
    expect(subject.features.resource).to be_a Moysklad::Resources::Features
  end

  it do
    expect(subject.metadata.resource).to be_a Moysklad::Resources::Metadata
  end

  it do 
    expect(subject.resources_list).to have_at_least(10).items
  end

  it do
    expect(subject.resources_list).to include(:features)
  end

end
