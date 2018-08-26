# frozen_string_literal: true

module Yasd
  class Converter
    def initialize(filename)
      @converters = {}
      contents = File.read(filename)
      instance_eval(contents)
    end

    def call(header, value)
      return unless @converters[header]
      @converters[header].reduce(value) do |result, proc|
        proc.call
      end
    end

    private

    def converter(header, &block)
      @converters[header] ||= []
      @converters[header] << block
    end
  end
end
