# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Services::SystemIdReceiver do
  let(:iban) { Ibanizator.iban_from_string('DE05740900000011111111') }
  let(:credentials) { build(:hbci_credentials) }
  let(:connector) { Hbci::Connector.new(credentials) }

  subject { described_class.new(connector) }

  before do
    allow_any_instance_of(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  context 'when requested via hksyn version 3' do
    before do
      stub_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_system_id_request_message(credentials, iban: iban)))
        .to_return(status: 200, body: Base64.encode64(stub_system_id_response_message(credentials)))
    end


    context 'when given an account number that is accessible' do
      it 'requests and returns the balance' do
        system_id = subject.perform

        expect(system_id).to eql('3709434306917000W15S4440RY65OC')
      end
    end
  end
end
