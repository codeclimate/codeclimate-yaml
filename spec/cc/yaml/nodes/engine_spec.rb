require 'spec_helper'

describe CC::Yaml::Nodes::Engine do
  specify 'enabled' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    YAML
    engine = config.engines["rubocop"]
    engine.enabled?.must_equal true
  end

  specify 'disabled' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: false
    YAML
    engine = config.engines["rubocop"]
    engine.enabled?.must_equal false
  end

  specify 'to_json' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    YAML

    json = config.engines.map { |_,v| v.to_json }.first
    json.must_equal %{{"enabled":true}}
  end

  specify 'checks' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    checks:
      Style/StringLiteral:
        enabled: false
    YAML

    checks = config.engines["rubocop"].checks
    check = checks["Style/StringLiteral"]
    check.enabled?.must_equal false
  end

  specify "config" do
    yaml = CC::Yaml.parse <<-YAML
engines:
  phpcodesniffer:
    enabled: true
    config:
      file_extensions: "php"
    YAML

    config = yaml.engines["phpcodesniffer"].config
    config.must_equal("file_extensions" => "php")
  end

  specify "config" do
    yaml = CC::Yaml.parse <<-YAML
engines:
  phpcodesniffer:
    enabled: true
    config: "config.php"
    YAML

    config = yaml.engines["phpcodesniffer"].config
    config.must_equal("file" => "config.php")
  end

  specify "ignored_issues" do
    yaml = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    ignored_issues:
      - be121740bf988b2225a313fa1f107ca1
      - 1ffc9f9cc376341aa08bb5973c511ac3
    YAML

    config = yaml.engines["rubocop"].ignored_issues
    config.must_equal([
      "be121740bf988b2225a313fa1f107ca1",
      "1ffc9f9cc376341aa08bb5973c511ac3"
    ])
  end
end
