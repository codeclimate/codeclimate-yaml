require "spec_helper"

module CC::Yaml::Nodes
  describe Sequence do
    def setup
      Root.class_eval do
        map :example, to: Sequence
      end
    end

    it "parses a single hash value" do
      config = CC::Yaml.parse(<<-EOYAML)
        example:
          foo: bar
      EOYAML

      expected = { "foo" => "bar" }
      config.example.must_equal([{ "foo" => "bar" }])
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

    it "parses complex arrays" do
      example = parse_example(<<-EOYAML)
        example:
        - foo: 123
        - bar:
            baz: foo
        - buzz
      EOYAML

      example.must_equal([
        { "foo" => "123" },
        { "bar" => { "baz" => "foo" } },
        "buzz",
      ])
    end

    def parse_example(yaml)
      CC::Yaml.parse(yaml).example
    end
  end
end
