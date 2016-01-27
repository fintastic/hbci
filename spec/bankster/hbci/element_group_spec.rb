require 'spec_helper'

describe Bankster::Hbci::ElementGroup do
  describe '#to_s' do
    context 'with multi elements' do
      let(:clazz) do
        Class.new(described_class) do
          element :test
          elements :entries
        end
      end

      context 'when the multi elements have content' do
        subject do
          eg = clazz.new
          eg.test = 'test'
          eg.entries.push('entry_1')
          eg.entries.push('entry_2')
          eg.entries.push('entry_3')
          eg.to_s
        end
        it { is_expected.to eql('test:entry_1:entry_2:entry_3') }
      end
    end

    context 'without multi elements' do
      let(:clazz) do
        Class.new(described_class) do
          element :a
          element :b
          element :c
        end
      end
      context 'when all elements have content' do
        subject do
          eg = clazz.new
          eg.a = "a"
          eg.b = "b"
          eg.c = "c"
          eg.to_s
        end
        it { is_expected.to eql('a:b:c') }
      end

      context 'when the first element is empty' do
        subject do
          eg = clazz.new
          eg.a = nil
          eg.b = "b"
          eg.c = "c"
          eg.to_s
        end
        it { is_expected.to eql(':b:c') }
      end

      context 'when the first and last element is empty' do
        subject do
          eg = clazz.new
          eg.a = nil
          eg.b = "b"
          eg.c = nil
          eg.to_s
        end
        it { is_expected.to eql(':b') }
      end

      context 'when the last element is empty' do
        subject do
          eg = clazz.new
          eg.a = "a"
          eg.b = "b"
          eg.c = nil
          eg.to_s
        end
        it { is_expected.to eql('a:b') }
      end

      context 'when the last 2 elements are empty' do
        subject do
          eg = clazz.new
          eg.a = "a"
          eg.b = nil
          eg.c = nil
          eg.to_s
        end
        it { is_expected.to eql('a') }
      end

      context 'when all are empty' do
        subject do
          eg = clazz.new
          eg.a = nil
          eg.b = nil
          eg.c = nil
          eg.to_s
        end
        it { is_expected.to eql('') }
      end
    end
  end

  describe '.elements' do
    context 'given a count' do
      let(:element_group_class) do
        Class.new(described_class) do
          elements :entries
        end
      end

      subject{ element_group_class.new }

      it 'enables the accessing of multiple elements as an array' do
        expect(subject).to respond_to(:entries)
        subject.entries.push(:test)
        expect(subject.entries.first).to eql(:test)
      end
    end
  end

  describe '.element' do
    context 'without any args' do
      subject do 
        Class.new(described_class) do
          element :test1
          element :test2
        end.new
      end

      it 'can save and return an element value' do
        subject[0] = 'test'
        expect(subject[0]).to eql('test')
      end

      it 'has a reader for its element' do
        subject[0] = 'test'
        expect(subject).to  respond_to(:test1)
        expect(subject.test1).to eql("test")
      end

      it 'has a writer for its element' do
        subject.test1 = "bla"
        expect(subject.test1).to eql("bla")
      end

      it 'works with multiple elements' do
        subject.test1 = "bla"
        subject.test2 = "blubb"
        expect(subject[0]).to eql("bla")
        expect(subject[1]).to eql("blubb")
      end
    end

    context 'given a default value' do
      subject do 
        class MyGroup < Bankster::Hbci::ElementGroup
          element :test1, default: "my_default_value"
          element :test2
        end
        MyGroup.new
      end

      it 'sets a default value' do
        expect(subject[0]).to eql('my_default_value')
      end
    end

    context 'given a default value as a block' do
      let(:time_1) { Time.new(2015,1,1) }
      let(:time_2) { Time.new(2015,2,1) }
      let(:time_3) { Time.new(2015,3,1) }

      it 'sets a default value' do
        Timecop.freeze(time_1)
        clazz = Class.new(Bankster::Hbci::ElementGroup) do
          element :test1, default: ->(eg) { Time.now }
        end
        Timecop.freeze(time_2)
        instance = clazz.new
        Timecop.freeze(time_3)
        expect(instance.test1).to eql(time_2)
        Timecop.return
      end
    end
  end
end
