require 'spec_helper'

describe 'HKEND' do
  describe Hbci::Segments::HKENDv1, type: :segment do
    describe '#compile' do
      it { expect(subject.to_s).to eql("HKEND:1:1+0'") }
    end
  end
end
