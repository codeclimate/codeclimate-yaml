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

  specify 'channel defaulted' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    YAML

    config.engines["rubocop"].channel.must_equal "stable"
  end

  specify 'channel present' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    channel: beta
    YAML

    config.engines["rubocop"].channel.must_equal "beta"
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
    exclude_fingerprints:
      - be121740bf988b2225a313fa1f107ca1
      - 1ffc9f9cc376341aa08bb5973c511ac3
    YAML

    config = yaml.engines["rubocop"].exclude_fingerprints
    config.must_equal([
      "be121740bf988b2225a313fa1f107ca1",
      "1ffc9f9cc376341aa08bb5973c511ac3"
    ])
  end

  specify "exclude_paths" do
    yaml = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    exclude_paths:
      - "**/*.rs"
      - "**/*.ex"
    YAML

    config = yaml.engines["rubocop"].exclude_paths
    config.must_equal([
      "**/*.rs",
      "**/*.ex"
    ])
  end
end
