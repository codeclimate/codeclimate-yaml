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

  specify "properly parses engine data" do
    yaml = <<-YAML
    ---
    engines:
      duplication:
        enabled: true
        config:
          ruby:
            mass_threshold: 10
          javascript:
            mass_threshold: 20
    YAML

    parsed_yaml = CC::Yaml.parse yaml
    config = parsed_yaml["engines"]["duplication"]["config"]

    assert config.empty?, false
    assert_equal config["ruby"]["mass_threshold"], 10
    assert_equal config["javascript"]["mass_threshold"], 20
  end

  specify "supports listed values" do
    yaml = <<-YAML
    ---
    engines:
      duplication:
        enabled: true
        languages:
          - "ruby"
          - "javascript"
    YAML

    parsed_yaml = CC::Yaml.parse yaml
    enabled_languages = parsed_yaml["engines"]["duplication"]["languages"]

    assert enabled_languages.nil? false
    assert_equal enabled_languages, ["ruby", "javascript"]
  end
end
