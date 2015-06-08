require 'spec_helper'

describe CC::Yaml::Nodes::ExcludePathList do
  specify 'empty section' do
    config = CC::Yaml.parse('exclude_paths:')
    config.exclude_paths.must_equal []
  end

  specify 'with a single value' do
    config = CC::Yaml.parse!('exclude_paths: spec')
    config.exclude_paths.must_equal ['spec']
  end

  specify 'with a list' do
    config = CC::Yaml.parse('exclude_paths: [spec, bin]')
    config.exclude_paths.must_equal ['spec', 'bin']
  end

  specify 'with a pattern' do
    config = CC::Yaml.parse <<-YAML
exclude_paths:
  - "spec/**/*.rb"
    YAML
    config.exclude_paths.must_equal ['spec/**/*.rb']
  end

  specify 'with invalid data' do
    config = CC::Yaml.parse <<-YAML
exclude_paths:
  foo: bar
    YAML
    config.nested_warnings.must_include [["exclude_paths"], "unexpected mapping"]
  end
end
