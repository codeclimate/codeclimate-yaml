require "spec_helper"

describe "Yaml file with everything" do
  let(:yaml) do
<<-YAML
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
checkout_submodules: true
ratings:
  paths:
  - "**.rb"
exclude_paths:
- "spec/**/*"
YAML
  end

  it "is valid" do
    config = CC::Yaml.parse(yaml)

    config.parseable?.must_equal(true)
    config.errors.must_equal([])
    config.warnings.must_equal([])
  end
end
