require 'spec_helper'

describe Moysklad do
  it 'should be loaded' do
    expect(Moysklad::Entities::Base).to  be_a Class
  end
end
