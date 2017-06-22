require 'spec_helper'

describe CC::Yaml::Nodes::IssueOverride do
  specify 'severity' do
    config = CC::Yaml.parse! <<-YAML
engines:
  rubocop:
    enabled: true
    issue_override:
      severity: info
    YAML
    engine = config.engines["rubocop"]
    engine.issue_override.severity.must_equal "info"
  end
end
