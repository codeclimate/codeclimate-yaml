require "spec_helper"

module CC::Yaml::Nodes
  describe Mapping do
    def setup
      Root.class_eval do
        map :example, to: Scalar[:bool]
      end
    end

    it "supports assignment of primitives" do
      config = CC::Yaml.parse("example: true")

      config.example = false
      config.example.must_equal false
    end

    it "supports assignment of node objects" do
      config_1 = CC::Yaml.parse("example: true")
      config_2 = CC::Yaml.parse("example: false")

      config_1.example = config_2.example
      config_1.example.is_a?(Node).must_equal true
      config_1.example.value.must_equal false
    end
  end
end
