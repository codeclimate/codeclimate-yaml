require 'spec_helper'

describe CC::Yaml::Nodes::Engine do
  specify 'default enabled' do
    config = CC::Yaml.parse <<-YAML
engines:
  rubocop:
    YAML
    config.engines.warnings.must_equal ['dropping "rubocop" section: missing key "enabled"']
  end

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

  specify 'assignment of raw value' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    YAML

    config.engines["rubocop"].enabled = false
    config.engines["rubocop"].enabled?.must_equal false
  end

  specify 'assignment of subnode' do
    config_1 = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    YAML
    config_2 = CC::Yaml.parse! <<-YAML
engines:
  eslint:
    enabled: true
    YAML

    config_2.engines = config_1.engines
    config_2.engines["rubocop"].enabled?.must_equal true
  end
end
