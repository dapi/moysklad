require 'spec_helper'

describe Moysklad::Universe do
  it 'should be loaded' do
    expect(Moysklad::Universe).to be_a Class
  end

  describe do
    let!(:client) { Moysklad::Client.new }

    subject { Moysklad::Universe.new client: client }

    it 'should have a features resoruce' do
      expect(subject.features).to be_a Moysklad::Resources::Indexed
      expect(subject.features.resource).to be_a Moysklad::Resources::Features
    end
  end

end
