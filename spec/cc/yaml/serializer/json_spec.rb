require 'spec_helper'

describe CC::Yaml::Serializer::Json do
  specify "serializes json" do
    config = CC::Yaml.parse('engines: { rubocop: { enabled: true }}')
    config.to_json.must_equal "{\"engines\":{\"rubocop\":{\"enabled\":true}}}"
  end
end
