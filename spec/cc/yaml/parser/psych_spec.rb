require "spec_helper"

describe CC::Yaml::Parser::Psych do
  specify "emits warning when no engines or languages key is found" do
    yaml = <<-YAML
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config = CC::Yaml.parse yaml
    config.errors.must_include CC::Yaml::Parser::Psych::NO_ANALYSIS_KEY_FOUND_ERROR
  end
end
