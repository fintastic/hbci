# frozen_string_literal: true

require 'spec_helper'

describe Hbci::ElementGroup do
  describe '#to_s' do
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
        eg.a = 'a'
        eg.b = 'b'
        eg.c = 'c'
        eg.to_s
      end
      it { is_expected.to eql('a:b:c') }
    end

    context 'when the first element is empty' do
      subject do
        eg = clazz.new
        eg.a = nil
        eg.b = 'b'
        eg.c = 'c'
        eg.to_s
      end
      it { is_expected.to eql(':b:c') }
    end

    context 'when the first and last element is empty' do
      subject do
        eg = clazz.new
        eg.a = nil
        eg.b = 'b'
        eg.c = nil
        eg.to_s
      end
      it { is_expected.to eql(':b') }
    end

    context 'when the last element is empty' do
      subject do
        eg = clazz.new
        eg.a = 'a'
        eg.b = 'b'
        eg.c = nil
        eg.to_s
      end
      it { is_expected.to eql('a:b') }
    end

    context 'when the last 2 elements are empty' do
      subject do
        eg = clazz.new
        eg.a = 'a'
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

  describe 'escaping of special chars' do
    context 'when given regular elements defined as single elements' do
      let(:clazz) do
        Class.new(described_class) do
          element :a
          element :b
          element :c
          element :d
        end
      end
      context 'when all elements have content' do
        subject do
          eg = clazz.new
          eg.a = 'te+st'
          eg.b = "te'st"
          eg.c = 'te?st'
          eg.d = 'te:st'
          eg.to_s
        end
        it { is_expected.to eql('te?+st:te?\'st:te??st:te?:st') }
      end
    end

    context 'when given binary elements' do
      let(:clazz) do
        Class.new(described_class) do
          element :a
          element :b, type: :binary
          element :c
          element :d
        end
      end

      context 'when all elements have content' do
        subject do
          eg = clazz.new
          eg.a = 'te+st'
          eg.b = 'a+sd'
          eg.c = 'te?st'
          eg.d = 'te:st'
          eg.to_s
        end

        it { is_expected.to eql('te?+st:@4@a+sd:te??st:te?:st') }
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
        expect(subject).to respond_to(:test1)
        expect(subject.test1).to eql('test')
      end

      it 'has a writer for its element' do
        subject.test1 = 'bla'
        expect(subject.test1).to eql('bla')
      end

      it 'works with multiple elements' do
        subject.test1 = 'bla'
        subject.test2 = 'blubb'
        expect(subject[0]).to eql('bla')
        expect(subject[1]).to eql('blubb')
      end
    end

    context 'given a default value' do
      subject do
        class MyGroup < Hbci::ElementGroup
          element :test1, default: 'my_default_value'
          element :test2
        end
        MyGroup.new
      end

      it 'sets a default value' do
        expect(subject[0]).to eql('my_default_value')
      end
    end

    context 'given a default value as a block' do
      let(:time_1) { Time.new(2015, 1, 1) }
      let(:time_2) { Time.new(2015, 2, 1) }
      let(:time_3) { Time.new(2015, 3, 1) }

      it 'sets a default value' do
        Timecop.freeze(time_1)
        clazz = Class.new(Hbci::ElementGroup) do
          element :test1, default: ->(_eg) { Time.now }
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
