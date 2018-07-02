# frozen_string_literal: true

require 'spec_helper'

describe Hbci::ElementGroups::SegmentHead do
  subject { described_class.new }

  it 'has accessors for type, position and version' do
    expect(subject).to respond_to(:type)
    expect(subject).to respond_to(:position)
    expect(subject).to respond_to(:version)

    expect(subject).to respond_to(:type=)
    expect(subject).to respond_to(:position=)
    expect(subject).to respond_to(:version=)
  end

  it 'can save attributes' do
    subject.type     = 'type'
    subject.position = 'position'
    subject.version  = 'version'
    expect(subject.type).to     eql('type')
    expect(subject.position).to eql('position')
    expect(subject.version).to  eql('version')
  end
end
