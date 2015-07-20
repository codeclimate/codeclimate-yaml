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
    config.errors.must_include CC::Yaml::Nodes::Mapping::INCOMPATIBLE_KEYS_WARNING
  end

  specify "with languages already present, it drops engines key and keeps languages" do
    config = CC::Yaml.parse <<-YAML
      languages:
        Ruby: true
        JavaScript: true
      engines:
        rubocop:
          enabled: true
    YAML
    config.engines.must_equal nil
    config.languages.must_equal({ "Ruby" => true, "JavaScript" => true })
  end
end
