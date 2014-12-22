require 'spec_helper'

describe Moysklad::Resources do
  it 'should be loaded' do
    expect(Moysklad::Resources).to be_a Module

    expect(Moysklad::Resources.resources).to include(Moysklad::Resources::Features)
    expect(Moysklad::Resources.resources).to include(Moysklad::Resources::EmbeddedEntityMetadata)
  end
end
