require 'spec_helper'

describe Bankster::Hbci::Parser do
  let(:parser) { described_class.new }

  describe '#escaped_reserved' do
    it 'parses escaped control characters' do
      expect(parser.escaped_reserved).to parse('??')
      expect(parser.escaped_reserved).to parse('?:')
      expect(parser.escaped_reserved).to parse('?+')
      expect(parser.escaped_reserved).to parse('?\'')
      expect(parser.escaped_reserved).to_not parse('?')
      expect(parser.escaped_reserved).to_not parse(':')
      expect(parser.escaped_reserved).to_not parse('+')
      expect(parser.escaped_reserved).to_not parse('\'')
    end
  end

  describe '#element_content_char' do
    it 'parses the element content' do
      expect(parser.element_content_char).to parse('a')
      expect(parser.element_content_char).to parse('x')
      expect(parser.element_content_char).to parse('z')
      expect(parser.element_content_char).to parse('Z')
    end
  end

  describe '#element' do
    it 'parses the element content' do
      expect(parser.element).to parse('a')
      expect(parser.element).to parse('Z')
      expect(parser.element).to parse('Zasdad')
      expect(parser.element).to_not parse('Za:sd')
      expect(parser.element).to parse('Za?:sd')
      expect(parser.element).to parse('@3@asd')
      expect(parser.element).to parse('@3@a:d')
    end
  end

  describe '#binary_length' do
    it 'parses the binary length' do
      expect(parser.binary_length).to parse('@123@')
      expect(parser.binary_length).to parse('@1@')
      expect(parser.binary_length).to_not parse('@@')
      expect(parser.binary_length).to_not parse('@asd@')
      expect(parser.binary_length).to_not parse('sd@')
    end
  end

  describe '#element_group' do
    it 'parses an element_group' do
      expect(parser.element_group).to parse('ab')
      expect(parser.element_group).to parse('adsa')
      expect(parser.element_group).to parse('asd:asd')
    end
  end

  describe '#segment' do
    it 'parses a segment' do
      expect(parser.segment).to parse("asd'")
      expect(parser.segment).to parse('aa+aa\'')
      expect(parser.segment).to parse('el1:el2+el3:el4+el5\'')
      expect(parser.segment).to parse('e?:l1:el2+el3:el4+el5\'')
      expect(parser.segment).to parse('e?:l1:@3@::::el2+el3:el4+el5\'')
    end
  end

  describe '#segments' do
    it 'parses multiple segments' do
      expect(parser.segments).to parse("a:a+a:s'b:sd+s:x'")
    end
  end

  describe 'transforming' do
    let(:tree) { parser.segments.parse(message) }
    let(:result) { Bankster::Hbci::Transform.new.apply(tree) }

    context 'when two segments are given' do
      let(:message) { "a:a+a:s'b:sd+s:x'" }

      it 'contains the correct elements' do
        expect(result).to eql([
          [['a','a'], ['a', 's']], 
          [['b', 'sd'], ['s', 'x']],
        ])
      end
    end

    context 'when one segment is given' do
      let(:message) { "a:a+a:s'" }

      it 'contains the correct elements' do
        expect(result).to eql([
          [['a','a'], ['a', 's']]
        ])
      end
    end

    context 'when one segment with standalone elements is given' do
      let(:message) { "a:a+s'" }

      it 'contains the correct elements' do
        expect(result).to eql([
          [['a','a'], ['s']]
        ])
      end
    end

    context 'when a segment with escaped special chars is given' do
      let(:message) { "hello?::what?'s+your:na?+me??'" }

      it 'contains the correct elements' do
        expect(result).to eql([
          [['hello?:','what?\'s'], ['your', 'na?+me??']]
        ])
      end
    end

    context 'when a segment with binary data is given' do
      let(:message) { "this:is:binary+data:@3@asd'" }

      it 'contains the correct elements' do
        expect(result).to eql([
          [['this', 'is', 'binary'], ['data','asd']]
        ])
      end
    end

    context 'when a segment with standalone binary data is given' do
      let(:message) { "this:is:binary+@3@asd'" }

      it 'contains the correct elements' do
        expect(result).to eql([
          [['this', 'is', 'binary'], ['asd']]
        ])
      end
    end
  end
end

