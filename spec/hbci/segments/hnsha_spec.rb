# frozen_string_literal: true

require 'spec_helper'

describe 'HNSHA' do
  describe Hbci::Segments::HNSHAv2, type: :segment do
    describe '#compile' do
      it { expect(subject.to_s).to eql("HNSHA:1:2+10999990++33333'") }
    end
  end
end
