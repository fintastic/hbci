# frozen_string_literal: true

require 'spec_helper'

describe 'HKSYN' do
  describe Hbci::Segments::HKSYNv3, type: :segment do
    describe '#compile' do
      it { expect(subject.to_s).to eql("HKSYN:1:3+0'") }
    end
  end
end
