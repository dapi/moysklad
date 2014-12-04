require 'spec_helper'

describe Moysklad::Entities::Country do

  before do
    stub_rest :Country, :list, 0
  end

  let(:resource) { Moysklad::Resources::Countries.indexed client: client }

  describe do
    let(:country) { resource.all.first }

    subject { country }

    it do
      expect(subject).to be_a Moysklad::Entities::Country
    end

    it 'unicoded xml' do
      expect(subject.to_xml).to start_with '<?xml version="1.0" encoding="utf-8"?>'
    end

  end
end
