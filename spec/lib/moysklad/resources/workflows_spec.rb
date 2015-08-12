require 'spec_helper'

describe Moysklad::Resources::Workflows do
  before do
    stub_rest 'Workflow'
  end

  subject { described_class.new client: client }

  it do
    expect(subject.list.count).to eq 2
  end

  it  do
    expect(subject.send(:list_path)).to  eq "exchange/rest/ms/xml/Workflow/list"
  end

  it do
    expect(subject.list.first).to be_a Moysklad::Entities::Workflow
  end
end
