require 'spec_helper'

describe Moysklad::Resources::Base do
  it 'should be loaded' do
    expect(Moysklad::Resources::Base).to be_a Class
  end

  describe 'правильно определяет название модели' do
    let!(:entity_class) { Moysklad::Entities::Computer = Class.new }
    subject { Moysklad::Resources::Computers = Class.new Moysklad::Resources::Base }

    it do
      expect(subject.entity_class).to eq entity_class
    end
  end
end
