# frozen_string_literal: true

require 'spec_helper'

describe 'HKIDN' do
  describe Hbci::Segments::HKIDNv2, type: :segment do
    describe '#compile' do
      it { expect(subject.to_s).to eql("HKIDN:1:2+280:74090000+22222222+0+1'") }
    end
  end
end
