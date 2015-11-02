require "spec_helper"
require "logger"

describe CC::Yaml do
  describe ".parse" do
    it "returns a node" do
      config = CC::Yaml.parse("yargle: bargle")
      config.class.must_equal CC::Yaml::Nodes::Root
      config.nested_warnings.must_equal [[[], CC::Yaml::Parser::Psych::NO_ANALYSIS_KEY_FOUND_ERROR], [[], 'unexpected key "yargle", dropping']]
    end

    it "returns a node with errors" do
      config = CC::Yaml.parse("yargle: poskgp;aerwet ;rgr:  ")
      config.class.must_equal CC::Yaml::Nodes::Root
      config.errors.must_equal ["syntax error: (<unknown>): mapping values are not allowed in this context at line 1 column 27"]
      config.parseable?.must_equal false
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
