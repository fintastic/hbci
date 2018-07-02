# frozen_string_literal: true

require 'spec_helper'

# describe Hbci::Transformer do
#
#   let(:tree) { Hbci::Parser.new.segments.parse(message) }
#   let(:result) { described_class.new.apply(tree) }
#
#   context 'when two segments are given' do
#     let(:message) { "a:a+a:s'b:sd+s:x'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['a','a'], ['a', 's']],
#         [['b', 'sd'], ['s', 'x']],
#       ])
#     end
#   end
#
#   context 'when one segment is given' do
#     let(:message) { "a:a+a:s'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['a','a'], ['a', 's']]
#       ])
#     end
#   end
#
#   context 'when one segment with standalone elementgroup is given' do
#     let(:message) { "a:a'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['a','a']]
#       ])
#     end
#   end
#
#   context 'when one segment with empty elementgroup is given' do
#     let(:message) { "a:b++c'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['a','b'], [], ['c']]
#       ])
#     end
#   end
#
#   context 'when one segment with empty elementgroups and empty elements is given' do
#     let(:message) { "a:b+++c::d++'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['a','b'], [], [], ['c', nil, 'd'], [], []]
#       ])
#     end
#   end
#
#   context 'when one segment with standalone elements is given' do
#     let(:message) { "a:a+s'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['a','a'], ['s']]
#       ])
#     end
#   end
#
#   context 'when a segment with escaped special chars is given' do
#     let(:message) { "hello?::what?'s+your:na?+me??'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['hello?:','what?\'s'], ['your', 'na?+me??']]
#       ])
#     end
#   end
#
#   context 'when a segment with binary data is given' do
#     let(:message) { "this:is:binary+data:@3@asd'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['this', 'is', 'binary'], ['data','@3@asd']]
#       ])
#     end
#   end
#
#   context 'when a segment with standalone binary data is given' do
#     let(:message) { "this:is:binary+@3@asd'" }
#
#     it 'contains the correct elements' do
#       expect(result).to eql([
#         [['this', 'is', 'binary'], ['@3@asd']]
#       ])
#     end
#   end
# end
