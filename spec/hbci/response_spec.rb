# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Response do
  let(:dialog)       { double }
  let(:credentials)  { build(:hbci_credentials) }
  let(:raw_response) { stub_dialog_init_response_message(credentials) }

  subject { described_class.new(raw_response) }

  describe '.find' do
    it { expect(subject.find('HNHBK') ).to be_a(Hbci::Segments::HNHBKv3) }
  end

  describe '.find_all' do
    it { expect(subject.find_all('HNHBK').size ).to eql(1) }
  end
end
