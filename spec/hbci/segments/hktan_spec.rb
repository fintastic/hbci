# frozen_string_literal: true

require 'spec_helper'

describe 'HKTAN' do
  describe Hbci::Segments::HKTANv6, type: :segment do
    describe '#compile' do
      before do
        subject.tan_mechanism = 4
        subject.seg_id = 'HKIDN'
      end

      it { expect(subject.to_s).to eql("HKTAN:1:6+4+HKIDN'") }
    end
  end
end
