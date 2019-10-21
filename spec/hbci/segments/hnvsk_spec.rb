# frozen_string_literal: true

require 'spec_helper'

describe 'HNVSK' do
  describe Hbci::Segments::HNVSKv3, type: :segment do
    describe '#compile' do
      let(:raw_segment) { "HNVSK:998:3+PIN:1+998+1+1::0+1:20180101:000100+2:2:13:@5@NOKEY:5:1+280:74090000:22222222:V:1:1+0'" }

      it { expect(subject.to_s).to eql(raw_segment) }
    end
  end
end
