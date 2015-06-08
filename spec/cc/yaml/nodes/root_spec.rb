require 'spec_helper'

describe CC::Yaml::Nodes::Root do
  describe "#inspect" do
    it "returns a node" do
      config = CC::Yaml.new
      config.inspect.must_equal "#<CC::Yaml::Nodes::Root:{}>"
    end
  end
end
