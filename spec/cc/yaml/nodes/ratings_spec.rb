require "spec_helper"

describe CC::Yaml::Nodes::Ratings do
  specify "with an invalid path, it drops nil values with a warning" do
    config = CC::Yaml.parse <<-YAML
      ratings:
        paths:
        - []
        - wut/*
    YAML

    config.ratings.paths.must_equal(["wut/*"])
    config.nested_warnings.first.must_equal([
      ["ratings", "paths"],
      "Discarding invalid value for CC::Yaml::Nodes::GlobList: nil",
    ])
  end
end
