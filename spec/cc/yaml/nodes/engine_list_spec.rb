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

  specify "with languages already present" do
    it "throws an incompatibility warning" do
      config = CC::Yaml.parse! <<-YAML
        languages:
        - Ruby
        - JavaScript
        - Python
        engines:
          rubocop:
            enabled: true
            YAML

      config.warnings.must_include "languages key already found, dropping key: engines. Analysis settings for Languages and Engines are both valid but mutually exclusive. Note: command line analysis requires an Engines configuration."
    end

    it "drops engines key and keeps languages key" do
      config = CC::Yaml.parse! <<-YAML
        languages:
        - Ruby
        engines:
          rubocop:
            enabled: true
            YAML

      config.engines.must_equal nil
      config.languages must_equal ["Ruby"]
    end
  end
end
