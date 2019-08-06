require 'spec_helper'

describe Moysklad::Entities::CustomerOrder do
  context 'generate' do
    subject {
      p= Moysklad::Entities::CustomerOrderPosition.new
      p.vat = 18
      p.price = Moysklad::Entities::Price.new
      p.price.value = 123
      p.reserve = 123

      co = Moysklad::Entities::CustomerOrder.new
      co.sum = Moysklad::Entities::Price.new
      co.sum.value = 456
      co.description = 'Описание'
      co.positions = [p]
      co
    }

    it 'to_json' do
      expect(subject.to_json).to be_a String
    end

    it 'to_s' do
      expect(subject.to_s).to be_a String
    end
  end
end
