require 'spec_helper'

describe Hbci::Segments::HNSHAv2 do
  subject { described_class.new }

  it 'has a head' do
    expect(subject).to respond_to(:head)
    expect(subject.head).to be_a(Hbci::ElementGroup)
    expect(subject.head).to respond_to(:type)
    expect(subject.head).to respond_to(:position)
    expect(subject.head).to respond_to(:version)
  end

  it 'has other elements' do
    expect(subject).to respond_to(:security_reference)
    expect(subject).to respond_to(:security_validation_result)
    expect(subject).to respond_to(:signature)
    expect(subject.signature).to respond_to(:pin)
    expect(subject.signature).to respond_to(:tan)
  end
end
