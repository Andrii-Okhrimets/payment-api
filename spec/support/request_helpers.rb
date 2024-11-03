# frozen_string_literal: true

module Helpers
  module RequestHelpers
    def self.load_schema(schema_path)
      file_path = "spec/support/schemas/#{schema_path}.json"

      JSON.parse(File.read(file_path))
    end
  end
end
