require 'spec_helper'

describe Moysklad::Client::Errors do
  it 'should be loaded' do
    expect(Moysklad::Resources).to be_a Module

    expect(Moysklad::Resources.resources).to include(Moysklad::Resources::Features)
  end

  describe 'catch errors' do

    let(:resource) { Moysklad::Resources::CustomEntityMetadata.new client: client }
    let(:file) { raise 'not setted' }
    let(:url)  { 'http://fake.url/' }
    let(:result) { Faraday.new( url ).get '/' }

    subject do
      described_class.build result
    end
    
    before do
      #Moysklad::Client::ParsedError
      stub_request(:get, url).to_return File.new( './spec/fixtures/' + file + '.raw' )
    end

    context 'wrong_user' do
      let(:file) { 'wrong_user' }

      let(:error) { Moysklad::Client::UnauthorizedError }

      it { expect{subject}.to raise_error error }
    end
    
    context 'wrong_password' do
      let(:file) { 'wrong_password' }
      let(:error) { Moysklad::Client::UnauthorizedError }

      it { expect{subject}.to raise_error error }
    end

    context 'wrong_type' do
      let(:file) { 'wrong_type' }
      let(:error) { Moysklad::Client::ParsedError }

      it { expect{subject}.to raise_error error }
    end

    context 'resource_forbidden' do
      let(:file) { 'resource_forbidden' }
      let(:error) { Moysklad::Client::ResourceForbidden }

      it { expect{subject}.to raise_error error }
    end

    describe 'encoding' do
      context 'forbidden' do
        let(:file) { 'resource_forbidden' }

        subject do
          Moysklad::Client::ResourceForbidden.new result
        end

        it { expect(subject.message).to eq '[403] JBWEB000065: HTTP Status 403 - ; JBWEB000123: Access to the specified resource has been forbidden.' }
        it { expect(subject.message.encoding).to eq Encoding::UTF_8 }
      end
      context 'wront_type' do
        let(:file) { 'wrong_type' }

        subject do
          Moysklad::Client::ParsedError.new result
        end

        it { expect(subject.message).to eq 'Wrong type: Unknown2' }
        it { expect(subject.message.encoding).to eq Encoding::UTF_8 }
      end
      context 'wrong_password' do
        let(:file) { 'wrong_password' }

        subject do
          Moysklad::Client::UnauthorizedError.new result
        end

        it { expect(subject.message).to eq '[401] JBWEB000065: HTTP Status 401 - Неправильный пароль или имя пользователя; JBWEB000121: This request requires HTTP authentication.' }
        it { expect(subject.message.encoding).to eq Encoding::UTF_8 }
      end
    end
  end


end
