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

    def call(data)
      data.headers.each_with_object({}) do |field, new_object|
        new_object[field] = convert_field(field, data[field])
        new_object
      end
    end

    private

    # for DSL
    def convert(header, &block)
      @converters[header] ||= []
      @converters[header] << block
    end

    def convert_field(header, value)
      (@converters[header] || []).reduce(value) do |_result, proc|
        proc.call(value)
      end
    end
  end
end
