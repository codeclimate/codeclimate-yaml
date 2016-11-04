require "spec_helper"

describe CC::Yaml::Nodes::FileDependencyList do
  def setup
    CC::Yaml::Nodes::Root.class_eval do
      map :example, to: CC::Yaml::Nodes::FileDependencyList
    end
  end

  it "parses a sequence" do
    example = parse_example(<<-EOYAML)
      example:
        - "http://example.com/file.json"
        - url: http://example.com/url
          path: foo.txt
    EOYAML

    example.must_equal([
      {
        url: "http://example.com/file.json",
        path: "file.json",
      },
      {
        url: "http://example.com/url",
        path: "foo.txt",
      }
    ])
  end

  def parse_example(yaml)
    CC::Yaml.parse(yaml).example
  end
end
