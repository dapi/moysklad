require 'spec_helper'

describe Moysklad::Entities::CustomerOrderPosition do
  context 'generate' do
    subject {
      p= Moysklad::Entities::CustomerOrderPosition.new 
      p.vat = 18
      p.basePrice = Moysklad::Entities::Price.new
      p.basePrice.sum = 123
      p.reserve = true
      p
    }

    it 'to_xml' do
      expect(subject.to_xml).to be_a String
    end

    it 'to_s' do
      expect(subject.to_s).to be_a String
    end

    it 'include xml' do
      expect(subject.to_xml).to include '<?xml version="1.0" encoding="utf-8"?>'
    end

    it 'include customerOrderPosition' do
      expect(subject.to_xml).to include "<customerOrderPosition"
    end

    it 'include basePrice' do
      expect(subject.to_xml).to include "<basePrice"
    end
  end

end
