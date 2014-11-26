require 'spec_helper'

describe Moysklad::Resources::Subresource do
  let(:item) { double key1: 1, key2: 2 }

  let(:items) { [item] }

  subject { described_class.new items }

  it { expect(subject.items).to eq items }

end

