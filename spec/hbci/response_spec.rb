require 'spec_helper'

describe Hbci::Response do
  let(:dialog)       { double }
  let(:credentials)  { build(:hbci_credentials) }
  let(:raw_response) { stub_dialog_init_response_message(credentials) }

  describe '.parse' do
    let(:subject) { described_class.parse(dialog: dialog, raw_response: raw_response) }
    it 'returns a Response object' do
      expect(subject).to be_a(described_class)
    end

    it 'contains a head' do
      expect(subject.head).to be_a(Hbci::Segments::HNHBKv3)
    end

    it 'contains a tail' do
      expect(subject.tail).to be_a(Hbci::Segments::HNHBSv1)
    end

    it 'contains a tail' do
      expect(subject.tail).to be_a(Hbci::Segments::HNHBSv1)
    end

    it 'contains a payload' do
      subject.payload.each do |segment|
        expect(segment.to_s).to be_a(String)
      end
    end
  end

  describe '#success' do
  end
end
