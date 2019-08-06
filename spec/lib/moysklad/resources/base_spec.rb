require 'spec_helper'

describe Moysklad::Resources::Base do
  it 'should be loaded' do
    expect(described_class).to be_a Class
  end
end
