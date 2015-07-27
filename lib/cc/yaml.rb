require "yaml"

module CC
  module Yaml
    autoload :Nodes, "cc/yaml/nodes"
    autoload :Parser, "cc/yaml/parser"
    autoload :Serializer, "cc/yaml/serializer"

    def self.parse(value)
      Parser.parse(value)
    end

    def self.parse!(value, file_name = ".codeclimate.yml", logger = Kernel)
      result = parse(value)

      result.nested_warnings.each do |key, message|
        logger.warn key.empty? ? "#{file_name}: #{message}" :
          "#{file_name}: #{key.join(?.)} section - #{message}"
      end

      result
    end

    def self.dump(value)
      YAML.dump(value)
    end

    def self.new
      Nodes::Root.new
    end
  end
end
