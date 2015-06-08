$LOAD_PATH.unshift(File.join(__FILE__, "../lib"))
require "cc/yaml/version"

Gem::Specification.new do |s|
  s.name        = "codeclimate-yaml"
  s.version     = CC::Yaml::VERSION
  s.summary     = "Code Climate YAML"
  s.license     = "MIT"
  s.authors     = "Code Climate"
  s.email       = "hello@codeclimate.com"
  s.homepage    = "https://codeclimate.com"
  s.description = "Code Climate YAML parser"

  s.files         = Dir["lib/**/*.rb"]
  s.require_paths = ["lib"]
end
