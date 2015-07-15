require "spec_helper"
require "logger"

describe CC::Yaml do
  describe ".parse" do
    it "returns a node" do
      config = CC::Yaml.parse("yargle: bargle")
      config.class.must_equal CC::Yaml::Nodes::Root
      config.nested_warnings.must_equal [[[], 'unexpected key "yargle", dropping'], [[], CC::Yaml::Parser::Psych::WARNING_NO_ANALYSIS_KEY_FOUND]]
    end
  end

  describe ".parse!" do
    it "emits warnings" do
      output = StringIO.new
      logger = Logger.new(output)
      config = CC::Yaml.parse!("foo: bar", ".codeclimate.yml", logger)
      output.string.must_match '.codeclimate.yml: unexpected key "foo", dropping'
    end
  end

  describe ".new" do
    it "returns a node" do
      config = CC::Yaml.new
      config.class.must_equal CC::Yaml::Nodes::Root
    end
  end
end
