require 'spec_helper'

describe Bankster::Hbci::Parser do
  let(:parser) { described_class.new(str) }

  describe '#parse' do
    it 'parses' do
      expect(described_class.new("asd'").parse).to eql([[['asd']]])
      expect(described_class.new("eins:zwei'").parse).to eql([[%w(eins zwei)]])
      expect(described_class.new("eins:zwei+drei'").parse).to eql([[%w(eins zwei), ['drei']]])
      expect(described_class.new("eins:zwei+drei'vier+@5@asdsd'").parse).to eql([[%w(eins zwei), ['drei']], [['vier'], ['asdsd']]])

      expect(described_class.new("ei??ns:zwei+drei'vier+@5@asdsd'").parse).to eql([[%w(ei?ns zwei), ['drei']], [['vier'], ['asdsd']]])
    end
  end
end
