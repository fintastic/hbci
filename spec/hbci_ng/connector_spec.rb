# frozen_string_literal: true

require 'spec_helper_hbci_ng'

describe HbciNg::Connector do
  let(:iban) { 'DE05740900000011111111' }

  subject { described_class.new(iban) }

  describe '#url' do
    context 'with valid bank list' do
      it 'returns endpoint url' do
        expect(subject.url).to eql('https://hbci11.fiducia.de/cgi-bin/hbciservlet')
      end
    end
  end
end
