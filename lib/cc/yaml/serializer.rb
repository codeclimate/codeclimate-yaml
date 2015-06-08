module CC
  module Yaml
    module Serializer
      NotSupportedError = Class.new(ArgumentError)

      autoload :Generic, "cc/yaml/serializer/generic"
      autoload :Json, "cc/yaml/serializer/json"
    end
  end
end
