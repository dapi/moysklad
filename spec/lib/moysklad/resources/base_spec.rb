require 'spec_helper'

describe Moysklad::Resources::Base do
  it 'should be loaded' do
    expect(described_class).to be_a Class
  end

  describe 'правильно определяет название модели' do
    let!(:entity_class) { Moysklad::Entities::Computer = Class.new }
    subject { Moysklad::Resources::Computers = Class.new described_class }

    it do
      expect(subject.entity_class).to eq entity_class
    end
  end

  describe 'испрвляет на лету xml с плохими символами' do
    let(:xml)    { File.read './spec/fixtures/bad_chars.xml' }
    let(:client) { Moysklad::Client.new }
    let(:res) { described_class.new client: client }

    before do
      allow(described_class).to receive(:entity_class).and_return Moysklad::Entities::CustomEntity
    end

    subject { res.send :parse_page, xml }

    it do
      expect{subject}.to_not raise_error 
    end

    context 'ошибка есть если парсинг напрямую' do
      before do
        expect_any_instance_of(described_class).to receive(:parse_content).and_return xml
      end
      it do
        expect{subject}.to raise_error Nokogiri::XML::SyntaxError
      end
    end
  end
end
