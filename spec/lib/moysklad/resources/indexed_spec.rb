require 'spec_helper'

describe Moysklad::Resources::Indexed do
  let(:items_count) { total_consignment_count }

  before do
    stub_consignments_requests
  end

  let(:resource) { Moysklad::Resources::Indexed.new consignments_resource }

  subject { resource }

  it 'загружено верное количество данных' do
    expect(subject.all.count).to eq items_count
    expect(subject.send(:index).count).to eq items_count
  end

  describe 'кешированные данные' do
    # uuid элемента со второй страницы
    let(:uuid) { 'eb18d236-2e22-11e4-ddb1-002590a28eca'}

    before do
      subject.all
    end

    it 'элемет получаем из кеша' do
      expect(subject.find uuid).to be_a consignments_resource.class.entity_class
      expect(WebMock).to have_requested(:get, resource_list_url(consignments_resource, 0)).once
      expect(WebMock).to have_requested(:get, resource_list_url(consignments_resource, 1000)).once
    end
  end

  describe 'filtered?' do
    subject { resource.send :filtered?, item, filter }

    context 'под фильтр попадает все если фильтр пуст' do
      let(:item) { double }
      let(:filter) { {} }
      it do
        expect(subject).to be true
      end
    end

    context 'отсеивает что не надо' do
      let(:item) { double some_key: 123 }
      let(:filter) { { some_key: 124} }
      it do
        expect(subject).to be false
      end
    end
    context 'фильтрует что надо' do
      let(:item) { double some_key: 123 }
      let(:filter) { { some_key: 123} }
      it do
        expect(subject).to be true
      end
    end
  end

end
