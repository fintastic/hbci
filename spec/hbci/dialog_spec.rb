# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Dialog do
  let(:credentials) { build(:hbci_credentials) }
  let(:connector) { Hbci::Connector.new(credentials) }
  let!(:dialog_init_request) { stub_dialog_init_request(credentials) }

  subject { described_class.new(connector) }

  around do |example|
    Timecop.freeze { example.run }
  end

  before do
    allow_any_instance_of(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  describe '#initiate' do
    it 'initiates the dialog' do
      expect(subject).to_not be_initiated

      subject.initiate

      expect(dialog_init_request).to have_been_made.once
      expect(subject).to be_initiated
    end

    context 'with top level error response' do
      let(:response) do
        msg = []
        msg << "HNHBK:1:3+000000000137+300+0+1+0:1'"
        msg << "HIRMG:2:2+9050::Teilweise fehlerhaft.'"
        msg << "HIRMS:3:2:998+9130:8,2:Inhalt syntaktisch ung�ltig.'"
        msg << "HNHBS:4:1+1'"
        msg.join
      end

      before do
        stub_request(:post, credentials.url).with(body: Base64.encode64(stub_dialog_init_request_message(credentials))).to_return(status: 200, body: Base64.encode64(response))
      end

      it 'raises an error' do
        expect { subject.initiate }.to raise_error(Hbci::DialogError, 'Initialization failed')
        expect(subject).not_to be_initiated
      end
    end

    context 'with error response' do
      let(:response) do
        msg = []
        msg << "HNHBK:1:3+000000000241+300+0+1+0:1'"
        msg << "HNVSK:998:3+PIN:1+998+1+2::0+1:20180716:110611+2:2:13:@8@:5:1+280:76010085:788584857:V:0:0+0'"
        msg << 'HNVSD:999:1+@76@'
        msg << "HIRMG:2:2+9800::Dialogabbruch.'"
        msg << "HIRMS:3:2:2+9210::Ung?ltige Kundensystem-ID.''"
        msg << "HNHBS:4:1+1'"
        msg.join
      end

      before do
        stub_request(:post, credentials.url).with(body: Base64.encode64(stub_dialog_init_request_message(credentials))).to_return(status: 200, body: Base64.encode64(response))
      end

      it 'raises an error' do
        expect { subject.initiate }.to raise_error(Hbci::DialogError, 'Initialization failed')
        expect(subject).not_to be_initiated
      end
    end
  end

  describe '#finish' do
    before do
      subject.initiate
    end

    before do
      stub_dialog_finish_request(credentials, 2)
    end

    it 'finishes the dialog' do
      subject.finish
    end
  end
end
