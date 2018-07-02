# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Dialog do
  describe 'initiate' do
    let(:credentials) { build(:hbci_credentials) }
    let!(:dialog_init_request) { stub_dialog_init_request(credentials) }

    subject { described_class.new(credentials) }

    before do
      Timecop.freeze
      allow(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
    end

    it 'initiates the dialog' do
      expect(subject).to_not be_initiated

      subject.initiate

      expect(dialog_init_request).to have_been_made.once
      expect(subject).to be_initiated
    end
  end
end
