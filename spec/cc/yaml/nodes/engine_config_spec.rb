require "spec_helper"

describe CC::Yaml::Nodes::EngineConfig do
  specify "parses the engine config with arbitrary keys and depths" do
    parsed_yaml = CC::Yaml.parse <<-YAML
    engines:
      duplication:
        enabled: true
        config:
          languages:
          - ruby
          - python
          a: "1"
          b:
            c:
              d: "2"
              e:
              - items
              - more items
              f:
                g: "last thing"
                h:
                  i: "whatever"
    YAML

    parsed_config = parsed_yaml.engines["duplication"].config
    expected_config = {
      "languages" => ["ruby", "python"],
      "a" => "1",
      "b" => {
        "c" => {
          "d" => "2",
          "e" => ["items", "more items"],
          "f" => { "g" => "last thing", "h" => { "i" => "whatever" } },
        }
      },
    }
    parsed_config.must_equal(expected_config)
  end

  it "parses a plain hash" do
    parsed_yaml = CC::Yaml.parse <<-YAML
    engines:
      engine_name:
        enabled: true
        config:
          foo: bar
          baz: boo
    YAML

    parsed_config = parsed_yaml.engines["engine_name"].config
    parsed_config.must_equal({
      "foo" => "bar",
      "baz" => "boo",
    })
  end

  it "parses a string in a special way" do
    parsed_yaml = CC::Yaml.parse <<-YAML
    engines:
      engine_name:
        enabled: true
        config: foobar
    YAML

    parsed_config = parsed_yaml.engines["engine_name"].config
    parsed_config.must_equal({
      "file" => "foobar",
    })
  end

  it "parses a map with a complex array" do
    parsed_yaml = CC::Yaml.parse <<-YAML
    engines:
      engine_name:
        enabled: true
        config:
          languages:
          - a:
              doot: doot
          - b
          - c
    YAML

    parsed_config = parsed_yaml.engines["engine_name"].config
    parsed_config.must_equal({
      "languages" => [
        { "a" => { "doot" => "doot" } },
        "b",
        "c",
      ]
    })
  end
end
