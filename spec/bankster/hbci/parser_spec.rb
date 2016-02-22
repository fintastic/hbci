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

  describe '#element_char' do
    it 'parses the element content' do
      expect(parser.element_char).to parse('a')
      expect(parser.element_char).to parse('x')
      expect(parser.element_char).to parse('z')
      expect(parser.element_char).to parse('Z')
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
      expect(parser.element_group).to parse('ab::')
      expect(parser.element_group).to parse('adsa')
      expect(parser.element_group).to parse('asd:asd')
    end
  end

  describe '#segment' do
    it 'parses a segment' do
      expect(parser.segment).to parse("a:b++c'")
      expect(parser.segment).to parse("asd:asd+asd::+asd'")
      expect(parser.segment).to parse("asd:asd++asd::+asd'")
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
end
