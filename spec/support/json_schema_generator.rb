# frozen_string_literal: true

JSON::SchemaGenerator.class_eval do
  def create_hash(statement_group, data, required_keys)
    statement_group.add '"type": "object"'

    required_keys ||= []
    required_string = required_keys.map(&:inspect).join ', '
    statement_group.add "\"required\": [#{required_string}]" unless required_keys.empty?
    statement_group.add create_hash_properties data, required_keys
    statement_group.add '"additionalProperties": false'
    statement_group
  end
end
