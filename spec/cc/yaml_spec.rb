require 'spec_helper'
require 'logger'

describe CC::Yaml do
  describe ".parse" do
    it "returns a node" do
      config = CC::Yaml.parse('yargle: bargle')
      config.class.must_equal CC::Yaml::Nodes::Root
      config.nested_warnings.must_equal [[[], 'unexpected key "yargle", dropping']]
    end
  end

  describe ".parse!" do
    it "emits warnings" do
      output = StringIO.new
      logger = Logger.new(output)
      config = CC::Yaml.parse!("foo: bar", ".codeclimate.yml", logger)
      output.string.must_match '.codeclimate.yml: unexpected key "foo", dropping'
    end

    it "returns a tailored warning for 'languages' key" do
      output = StringIO.new
      logger = Logger.new(output)
      config = CC::Yaml.parse!("languages: ruby", ".codeclimate.yml", logger)
      output.string.must_match '.codeclimate.yml: analysis by language not available via CLI. Use engines configuration instead.'
    end

    it "does not return duplicate warning messages" do
      config_yaml = CC::Yaml.parse("languages: ruby")
      config_yaml.warnings.length.must_equal 1
    end
  end

  describe ".new" do
    it "returns a node" do
      config = CC::Yaml.new
      config.class.must_equal CC::Yaml::Nodes::Root
    end
  end
end
