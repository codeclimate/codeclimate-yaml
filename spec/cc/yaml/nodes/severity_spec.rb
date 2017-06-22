require "spec_helper"

describe CC::Yaml::Nodes::Severity do
  it "normalizes value" do
    config = CC::Yaml.parse <<-YAML
      engines:
        rubocop:
          enabled: true
          issue_override:
            severity: Major
    YAML

    config.engines["rubocop"].issue_override.severity.must_equal "major"
  end

   %w[info minor major critical blocker].each do |severity|
    it "assepts #{severity}" do
      config = CC::Yaml.parse <<-YAML
        engines:
          rubocop:
            enabled: true
            issue_override:
              severity: #{severity}
      YAML

      config.engines["rubocop"].issue_override.severity.must_equal severity
      config.errors.must_equal []
    end
   end

  specify "with invalid data, emits an error" do
    config = CC::Yaml.parse <<-YAML
      engines:
        rubocop:
          enabled: true
          issue_override:
            severity: "RED ALERT!!!"
    YAML
    config.errors.must_include %(invalid "engines" section: invalid "rubocop" section: invalid "issue_override" section: invalid "severity" section: Unexpected severity "RED ALERT!!!")
  end
end
