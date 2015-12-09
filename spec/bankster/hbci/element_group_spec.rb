require 'spec_helper'

describe Bankster::Hbci::ElementGroup do
  describe '#define_element' do
    subject { Bankster::Hbci::ElementGroup.new }
    context 'when called with a name' do
      before do
        subject.define_element(:test)
      end
      it 'hast a getter' do
        expect(subject).to respond_to(:test)
      end

      it 'has a setter' do
        expect(subject).to respond_to(:test=)
      end

      it 'can save and return with the accessors' do
        subject.test = "bla"
        expect(subject.test).to eql("bla")
      end

      it 'has an array accessor' do
        subject[0] = "xy"
        expect(subject.test).to eql("xy")
      end
    end
  end

  describe '.element' do
    context 'without any args' do
      subject do 
        class MyGroup < Bankster::Hbci::ElementGroup
          element :test1
          element :test2
        end
        MyGroup.new
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
  end
end
