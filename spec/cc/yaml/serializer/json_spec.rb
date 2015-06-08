require 'spec_helper'

describe CC::Yaml::Serializer::Json do
  specify "serializes json" do
    yaml = <<-YAML
    engines:
      rubocop:
        enabled: true
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config = CC::Yaml.parse yaml
    config.to_json.must_equal "{\"engines\":{\"rubocop\":{\"enabled\":true}},\"exclude_paths\":[\"*.rb\",\"test/*\"]}"
  end
end
