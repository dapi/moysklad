require 'spec_helper'

describe Moysklad::Entities::CustomerOrder do

  subject { Moysklad::Entities::CustomerOrder.new }

  it 'to_xml' do
    expect(subject.to_xml).to be_a String
  end

  it 'to_s' do
    expect(subject.to_s).to be_a String
    expect(subject.to_s).to include "<?xml"
    expect(subject.to_s).to include "<customerOrder"
  end

end
