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

    it "normalizes format for directory path endings, making all '**/*'" do
      example = parse_example(<<-EOYAML)
        example:
        - foo/**
        - bar/**/*
        - baz
      EOYAML

      example.must_equal(["foo/**/*", "bar/**/*", "baz"])
    end

    it "normalizes format for extension path beginnings, making all '**/*.extension'" do
      example = parse_example(<<-EOYAML)
        example:
        - "**.rb"
        - "**/*.js"
        - ".go"
      EOYAML

      example.must_equal(["**/*.rb", "**/*.js", ".go"])
    end

    def parse_example(yaml)
      CC::Yaml.parse(yaml).example
    end
  end
end
