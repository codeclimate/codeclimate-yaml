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
end
