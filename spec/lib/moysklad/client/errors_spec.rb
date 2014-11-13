require 'spec_helper'

describe Moysklad::Client::Errors do
  it 'should be loaded' do
    expect(Moysklad::Resources).to be_a Module

    expect(Moysklad::Resources.resources).to include(Moysklad::Resources::Features)
  end
end

