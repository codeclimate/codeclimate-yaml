require "spec_helper"

module CC::Yaml::Nodes
  describe OpenMapping do
    def setup
      Root.class_eval do
        map :example, to: OpenMapping
      end
    end

    it "parses a hash" do
      config = parse_example(<<-EOYAML)
        example:
          foo: bar
          baz: 123
      EOYAML

      config.must_equal({ foo: "bar", baz: "123" })
    end

    it "parses a sub-hash" do
      config = parse_example(<<-EOYAML)
        example:
          foo:
            bar: booboo
          baz: 123
      EOYAML

      config.must_equal({
        foo: { bar: "booboo" },
        baz: "123"
      })
    end

    it "parses empty values" do
      parse_example("example:").must_equal({})
    end

    def parse_example(yaml)
      CC::Yaml.parse(yaml).example
    end
  end
end
