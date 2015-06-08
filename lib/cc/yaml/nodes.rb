module CC
  module Yaml
    module Nodes
      autoload :Engine, "cc/yaml/nodes/engine"
      autoload :EngineList, "cc/yaml/nodes/engine_list"
      autoload :ExcludePath, "cc/yaml/nodes/exclude_path"
      autoload :ExcludePathList, "cc/yaml/nodes/exclude_path_list"
      autoload :Mapping, "cc/yaml/nodes/mapping"
      autoload :Node, "cc/yaml/nodes/node"
      autoload :OpenMapping, "cc/yaml/nodes/open_mapping"
      autoload :Root, "cc/yaml/nodes/root"
      autoload :Scalar, "cc/yaml/nodes/scalar"
      autoload :Sequence, "cc/yaml/nodes/sequence"

      def self.[](key)
        return key if key.respond_to? :new
        name = constants.detect { |c| c.downcase == key }
        raise ArgumentError, "unknown node type %p" % key unless name
        const_get(name)
      end
    end
  end
end
