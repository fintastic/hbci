# frozen_string_literal: true

module Hbci
  class Message
    attr_reader :connector, :dialog, :segments, :sec_ref
    attr_accessor :next_position

    def initialize(connector, dialog = nil)
      @connector = connector
      @dialog = dialog
      @sec_ref = generate_security_reference
      @segments = []
      @next_position = 1
    end

    def add_segment(segment)
      segment.build(self)
      @segments.push(segment)
    end

    def compile
      @segments.each_with_index do |segment, _index|
        segment.compile
        unless segment.head.position
          segment.head.position = @next_position
          @next_position += 1
        end
      end
      @segments.each do |segment|
        segment.after_compile if segment.respond_to?(:after_compile)
      end
    end

    def to_s
      segments.join('')
    end

    def to_base64
      Base64.encode64(to_s)
    end

    private

    def generate_security_reference
      rand(1..23) * 999_999 + 1_000_000
    end
  end
end
