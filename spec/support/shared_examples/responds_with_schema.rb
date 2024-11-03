shared_examples 'responds with schema' do |schema_path|
  run_test! do
    file_path = "spec/support/schemas/#{schema_path}.json"

    unless File.exist?(file_path)
      FileUtils.mkdir_p(File.dirname(file_path)) unless File.directory?(file_path)

      file_name = schema_path.split('/').last
      schema = JSON::SchemaGenerator.generate("#{file_name}.json", response.body)
      formatted_schema = JSON.pretty_generate(JSON.parse(schema))

      File.write(file_path, "#{formatted_schema}\n")
    end

    expect(response).to match_json_schema(schema_path)
  end
end
