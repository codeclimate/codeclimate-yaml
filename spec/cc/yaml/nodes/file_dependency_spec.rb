require "spec_helper"

describe CC::Yaml::Nodes::FileDependency do
  def setup
    CC::Yaml::Nodes::Root.class_eval do
      map :example, to: CC::Yaml::Nodes::FileDependency
    end
  end

  it "accepts a mapping" do
    example = parse_example(<<-EOYAML)
      example:
        url: http://example.com/url
        path: foo.txt
    EOYAML

    example.must_equal({
      url: "http://example.com/url",
      path: "foo.txt",
    })
  end

  it "supplies path if only url is supplied" do
    example = parse_example(<<-EOYAML)
      example:
        url: http://example.com/url
    EOYAML

    example.must_equal({
      url: "http://example.com/url",
      path: "url",
    })
  end

  it "converts a string" do
    example = parse_example(<<-EOYAML)
      example: "http://example.com/url"
    EOYAML

    example.must_equal({
      url: "http://example.com/url",
      path: "url",
    })
  end

  describe "validations" do
    it "validates url" do
      config = CC::Yaml.parse(<<-EOYAML)
        example: "not://valid"
      EOYAML

      config.errors[0].must_match(/invalid URL/)
    end

    it "validates that path exists" do
      config = CC::Yaml.parse(<<-EOYAML)
        example: "http://example.com"
      EOYAML

      config.errors[0].must_match(/path cannot be empty/)
    end

    it "validates that path is not absolute" do
      config = CC::Yaml.parse(<<-EOYAML)
        example:
          url: "http://example.com"
          path: /var/log/thing.txt
      EOYAML

      config.errors[0].must_match(%r{absolute path "/var/log/thing.txt" is invalid})
    end

    it "validates that path is relative outside of root" do
      config = CC::Yaml.parse(<<-EOYAML)
        example:
          url: "http://example.com"
          path: "../thing.txt"
      EOYAML

      config.errors[0].must_match(%r{relative path elements in "../thing.txt" are invalid})

      config = CC::Yaml.parse(<<-EOYAML)
        example:
          url: "http://example.com"
          path: "sub/../../thing.txt"
      EOYAML

      config.errors[0].must_match(%r{relative path elements in "sub/../../thing.txt" are invalid})
    end
  end

  def parse_example(yaml)
    CC::Yaml.parse(yaml).example
  end
end
