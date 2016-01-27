require 'spec_helper'

describe Bankster::Hbci::Segment do
  describe '.element' do
    context 'given one element without args' do
      subject do
        clazz = Class.new(described_class)
        clazz.element(:my_element)
        clazz.element_groups_to_be_defined
      end
      it 'adds the element group to the definition list' do
        expect(subject).to be_a(Array)
      end
      it 'adds the element group to the definition list' do
        expect(subject).to be_a(Array)
        expect(subject.count).to eql(1)
        expect(subject.first[:name]).to eql(:my_element)
        expect(subject.first[:elements]).to eql([{name: :my_element}])
      end
    end

    describe 'accessing the single element in the element group' do
      subject do
        clazz = Class.new(described_class)
        clazz.element(:my_element)
        clazz.new
      end
      it 'enables a direct reader for the element in the element group' do
        subject.element_groups[0].elements[0] = "asdasd"
        expect(subject.my_element).to eql("asdasd")
      end
    end


    context 'given one element with a default value' do
      subject do
        clazz = Class.new(described_class)
        clazz.element(:my_element, default: "asd")
        clazz.element_groups_to_be_defined
      end

      it 'adds the element group to the definition list' do
        expect(subject).to be_a(Array)
      end

      it 'adds the element group to the definition list' do
        expect(subject).to be_a(Array)
        expect(subject.count).to eql(1)
        expect(subject.first[:name]).to eql(:my_element)
        expect(subject.first[:elements]).to eql([{name: :my_element, default: "asd"}])
      end
    end
  end

  describe '.element_group' do
    context 'given one element group with a specified type' do
      subject do
        element_group_class = Class.new(Bankster::Hbci::ElementGroup) do
          element :a
          element :b
        end

        clazz = Class.new(described_class) do
          element_group :head, type: element_group_class
        end
        clazz.new
      end
      it 'has a defined head with accessors' do
        expect(subject).to respond_to(:head)
        expect(subject.element_groups[0]).to respond_to(:a)
        expect(subject.element_groups[0]).to respond_to(:b)
        expect(subject.head).to respond_to(:a)
        expect(subject.head).to respond_to(:b)
      end

      it 'has working accessors for the elements' do
        subject.head.a = "test"
        expect(subject.head.a).to eql("test")
      end
    end

    context 'given one element group with elements' do
      subject do
        clazz = Class.new(described_class)
        clazz.element_group(:my_group, elements: [:a, :b])
        clazz.element_groups_to_be_defined
      end
      it 'adds the element group to the definition list' do
        expect(subject).to be_a(Array)
        expect(subject.count).to eql(1)
        expect(subject.first[:name]).to eql(:my_group)
        expect(subject.first[:elements]).to eql([:a, :b])
      end
    end

    context 'given multiple element groups with elements' do
      subject do
        clazz = Class.new(described_class)
        clazz.element_group(:my_group_1, elements: [:a, :b])
        clazz.element_group(:my_group_2, elements: [:c, :d])
        clazz.element_groups_to_be_defined
      end

      it 'adds the element groups to the definition list' do
        expect(subject).to be_a(Array)
        expect(subject.count).to eql(2)
        expect(subject.first[:name]).to eql(:my_group_1)
        expect(subject.first[:elements]).to eql([:a, :b])
        expect(subject.last[:name]).to eql(:my_group_2)
        expect(subject.last[:elements]).to eql([:c, :d])
      end
    end

    context 'given an element group with a block of elements' do
      subject do
        segment_class = Class.new(Bankster::Hbci::Segment) do
          element_group :asd do
            element :x
            element :y
          end
          element_group :my_test1 do
            element :a
            element :b
          end
          element_group :my_test2 do
            element :c
          end
        end
        segment_class.new
      end

      it 'creates the element groups' do
        expect(subject.element_groups[0]).to be_a(Bankster::Hbci::ElementGroup)
        expect(subject.defined_element_groups).to eql([:asd, :my_test1, :my_test2])
        expect(subject.my_test1).to respond_to(:a)
        expect(subject.my_test1).to respond_to(:b)
        expect(subject.my_test2).to respond_to(:c)
      end

      it 'enables the accessors' do
        expect(subject.defined_element_groups).to eql([:asd, :my_test1, :my_test2])
        expect(subject.element_groups[0]).to be_a(Bankster::Hbci::ElementGroup)
        expect(subject.my_test1).to be_a(Bankster::Hbci::ElementGroup)
      end
    end

    context 'given element groups' do
      subject do
        segment_class = Class.new(Bankster::Hbci::Segment) do
          element_group :my_test1, elements: [{name: :a, default: "asd"}, :b, :c]
          element_group :my_test2, elements: [:x, :y, :c]
        end
        segment_class.new
      end

      it 'can save and return element groups' do
        expect(subject).to respond_to(:my_test1)
      end

      it 'returns an element group' do
        expect(subject.my_test1).to be_a(Bankster::Hbci::ElementGroup)
      end

      it 'has array accessors' do
        expect(subject[0]).to be_a(Bankster::Hbci::ElementGroup)
      end

      it 'has the getters' do
        expect(subject.my_test1).to respond_to(:a)
      end

      it 'has a default value' do
        expect(subject.my_test1.a).to eql("asd")
      end
    end
  end
end
