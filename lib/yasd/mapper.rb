# frozen_string_literal: true

module Yasd
  class Mapper
    def initalize(filepath)
      @mappings = YAML.load_file(filepath)
    end

    def call(data)
      data.each_with_object({}) do |(field, value), new_object|
        new_key = @mappings[field] || field
        new_object[new_key] = value
        new_object
      end
    end
  end
end
