# frozen_string_literal: true

require 'spec_helper_hbci_ng'

describe HbciNg::Config do
  it 'setter and getter' do
    described_class.product_name = 'TEST NAME'
    expect(described_class.product_name).to eql('TEST NAME')
  end

  it 'block' do
    HbciNg.configure do |config|
      config.product_name = 'TEST NAME'
    end

    expect(described_class.product_name).to eql('TEST NAME')
  end
end
