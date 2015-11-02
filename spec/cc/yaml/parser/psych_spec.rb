require "spec_helper"

describe CC::Yaml::Parser::Psych do
  specify "emits error when no engines or languages key is found" do
    yaml = <<-YAML
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config = CC::Yaml.parse yaml
    config.errors.must_include CC::Yaml::Parser::Psych::NO_ANALYSIS_KEY_FOUND_ERROR
  end

  specify "does not emit no-key error if other errors occurred" do
    yaml = <<-YAML
    engines:
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config = CC::Yaml.parse yaml
    config.errors.count.must_be :>, 0
    config.errors.wont_include CC::Yaml::Parser::Psych::NO_ANALYSIS_KEY_FOUND_ERROR
  end

  specify "does not emit any errors for valid input" do
    yaml = <<-YAML
    engines:
      rubocop:
        enabled: true
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config = CC::Yaml.parse yaml
    config.errors.count.must_equal 0
  end
end
