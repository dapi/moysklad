require 'spec_helper'

describe Moysklad::Resources::Countries do
  before do
    stub_rest 'Country'
  end

  subject { described_class.new client: client }

  it do
    expect(subject.list.count).to eq 248
  end

  it  do
    expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/Country/list"
  end

  it do
    expect(subject.list.first).to be_a Moysklad::Entities::Country
  end

end
