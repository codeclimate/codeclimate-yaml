require "spec_helper"

module CC::Yaml::Nodes
  describe Sequence do
    def setup
      Root.class_eval do
        map :example, to: Sequence
      end
    end

    it "warns for invalid data" do
      example = parse_example(<<-EOYAML)
        example:
          foo: bar
      EOYAML

      example.warnings.must_equal(["unexpected mapping"])
    end

    it "parses empty values" do
      parse_example("example:").must_equal([])
    end

    it "parses single values" do
      parse_example("example: foo").must_equal(["foo"])
    end

    it "parses literal arrays" do
      parse_example("example: [foo, bar]").must_equal(["foo", "bar"])
    end

    it "parses yaml arrays" do
      example = parse_example(<<-EOYAML)
        example:
        - foo
        - bar
        - baz
      EOYAML

      example.must_equal(["foo", "bar", "baz"])
    end

    def parse_example(yaml)
      CC::Yaml.parse(yaml).example
    end
  end
end
