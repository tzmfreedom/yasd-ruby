# frozen_string_literal: true

module Yasd
  class Converter
    def initialize(filename)
      @converters = {}
      if filename
        contents = File.read(filename)
        instance_eval(contents)
      end
    end

    def call(header, value)
      (@converters[header] || []).reduce(value) do |_result, proc|
        proc.call(value)
      end
    end

    private

      def convert(header, &block)
        @converters[header] ||= []
        @converters[header] << block
      end
  end
end
