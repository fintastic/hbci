# frozen_string_literal: true

require 'spec_helper_hbci_ng'

describe HbciNg::Parser do
  subject { described_class.new(sample, '+') }

  let(:sample) { "TEST:1:11+EL2+EL?+3:EL4+@4@TEST+@28@SUBTEST1:2:22'SUBTEST2:2:22'" }

  it 'returns value' do
    raw_segments = []
    subject.parse do |raw_segment|
      raw_segments << raw_segment
    end

    expect(raw_segments[0]).to eql('TEST:1:11')
    expect(raw_segments[1]).to eql('EL2')
    expect(raw_segments[2]).to eql('EL?+3:EL4')
    expect(raw_segments[3]).to eql('@4@TEST')
    expect(raw_segments[4]).to eql("@28@SUBTEST1:2:22'SUBTEST2:2:22'")
  end
end
