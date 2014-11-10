require 'spec_helper'

describe Moysklad do
  it 'should be loaded' do
    expect(Moysklad::Resources::Base).to be_a Class
    expect(Moysklad::Entities::Base).to  be_a Class
    expect(Moysklad::Entities::Company).to be_a Class
  end
end
