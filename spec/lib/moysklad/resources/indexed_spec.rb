require 'spec_helper'

describe Moysklad::Resources::Indexed do
  let(:items_count) { total_consignment_count }

  before do
    stub_consignments_requests
  end

  subject { Moysklad::Resources::Indexed.new consignments_resource }

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
      expect(subject.get uuid).to be_a consignments_resource.class.entity_class
      expect(WebMock).to have_requested(:get, resource_list_url(consignments_resource, 0)).once
      expect(WebMock).to have_requested(:get, resource_list_url(consignments_resource, 1000)).once
    end
  end

end

