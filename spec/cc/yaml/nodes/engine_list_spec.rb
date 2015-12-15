require "spec_helper"

describe CC::Yaml::Nodes::EngineList do
  specify "with engines" do
    config = CC::Yaml.parse! <<-YAML
      engines:
        foo:
          enabled: true
    YAML
    config.engines.size.must_equal 1
    config.engines.keys.must_equal ["foo"]
  end

  specify "with languages already present, it throws a warning" do
    config = CC::Yaml.parse <<-YAML
      languages:
        Ruby: true
        JavaScript: true
      engines:
        rubocop:
          enabled: true
    YAML
    config.warnings.must_include CC::Yaml::Nodes::Mapping::INCOMPATIBLE_KEYS_WARNING
  end

  specify "with languages already present, it keeps both engines and languages keys" do
    config = CC::Yaml.parse <<-YAML
      languages:
        Ruby: true
        JavaScript: true
      engines:
        rubocop:
          enabled: true
    YAML
    config.engines.must_equal("rubocop" => { "enabled" => true })
    config.languages.must_equal("Ruby" => true, "JavaScript" => true)
  end

  specify "with invalid data, emits an error" do
    config = CC::Yaml.parse <<-YAML
    engines:
      - "not_an_engine"
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config.errors.must_include "invalid \"engines\" section: unexpected sequence. #{CC::Yaml::Nodes::EngineList::GENERIC_ERROR_MESSAGE}"
  end

  specify "with empty, emits an error" do
    config = CC::Yaml.parse <<-YAML
    engines:
    exclude_paths:
      - "*.rb"
      - "test/*"
    YAML
    config.errors.must_include "invalid \"engines\" section: #{CC::Yaml::Nodes::EngineList::EMPTY_ERROR_MESSAGE}"
  end

  specify "with only disabled engines, emits an error" do
    config = CC::Yaml.parse <<-YAML
    engines:
      fixme:
        enabled: false
    YAML
    config.errors.must_include("invalid \"engines\" section: #{CC::Yaml::Nodes::EngineList::NO_ENABLED_ERROR_MESSAGE}")
  end
end
