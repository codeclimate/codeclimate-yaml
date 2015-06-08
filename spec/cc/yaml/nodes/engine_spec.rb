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
end
