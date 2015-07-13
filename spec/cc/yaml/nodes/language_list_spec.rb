require "spec_helper"

describe CC::Yaml::Nodes::LanguageList do
  specify "with languages" do
    config = CC::Yaml.parse! <<-YAML
      languages:
        Ruby: true
        JavaScript: true
        Python: false
    YAML
    config.languages.size.must_equal 3
    config.languages.must_equal({ "Ruby" => true, "JavaScript" => true, "Python" => false })
  end

  specify "with engines already present, it throws an incompatibility warning" do
    config = CC::Yaml.parse! <<-YAML
      engines:
        rubocop:
          enabled: true
      languages:
        Ruby: true
        JavaScript: true
        Python: false
    YAML
    config.warnings.must_include "engines key already found, dropping key: languages. Analysis settings for Languages and Engines are both valid but mutually exclusive. Note: command line analysis requires an Engines configuration."
  end

  specify "with engines already present, it leaves engines key and drops languages key" do
    config = CC::Yaml.parse! <<-YAML
      engines:
        rubocop:
          enabled: true
      languages:
        Ruby: true
        JavaScript: true
        Python: false
    YAML
    config.engines.keys.must_equal ["rubocop"]
    config.languages.must_equal nil
  end
end
