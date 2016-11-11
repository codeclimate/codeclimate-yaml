require "spec_helper"

describe "Yaml file with everything" do
  let(:yaml) do
<<-YAML
prepare:
  fetch_files:
    - "http://example.com/foo.json"
    - url: "https://example.com/bar.yml"
      path: baz.yml
engines:
  rubocop:
    enabled: true
    config:
      fun_feature: true
  eslint:
    enabled: true
    config:
      things:
      - one
      - two
  duplication:
    enabled: true
    config:
      languages:
        ruby:
          mass_threshold: 20
        python:
  weirdo:
    enabled: false
    config:
      thing:
      - hash:
          key: foo
      - 2
      - bar
checkout_submodules: true
ratings:
  paths:
  - "**.rb"
exclude_paths:
- "spec/**/*"
- "**/path.rb"
YAML
  end

  it "is valid" do
    config = CC::Yaml.parse(yaml)

    config.parseable?.must_equal(true)
    config.errors.must_equal([])
    config.warnings.must_equal([])
  end
end
