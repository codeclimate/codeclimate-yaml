module CC
  module Yaml
    module Nodes
      autoload :Check, "cc/yaml/nodes/check"
      autoload :Checks, "cc/yaml/nodes/checks"
      autoload :Prepare, "cc/yaml/nodes/prepare"
      autoload :Engine, "cc/yaml/nodes/engine"
      autoload :EngineConfig, "cc/yaml/nodes/engine_config"
      autoload :EngineList, "cc/yaml/nodes/engine_list"
      autoload :Fetch, "cc/yaml/nodes/fetch"
      autoload :FetchList, "cc/yaml/nodes/fetch_list"
      autoload :Glob, "cc/yaml/nodes/glob"
      autoload :GlobList, "cc/yaml/nodes/glob_list"
      autoload :IssueOverride, "cc/yaml/nodes/issue_override"
      autoload :LanguageList, "cc/yaml/nodes/language_list"
      autoload :Mapping, "cc/yaml/nodes/mapping"
      autoload :NestedConfig, "cc/yaml/nodes/nested_config"
      autoload :Node, "cc/yaml/nodes/node"
      autoload :OpenMapping, "cc/yaml/nodes/open_mapping"
      autoload :Ratings, "cc/yaml/nodes/ratings"
      autoload :Root, "cc/yaml/nodes/root"
      autoload :Scalar, "cc/yaml/nodes/scalar"
      autoload :Sequence, "cc/yaml/nodes/sequence"
      autoload :Severity, "cc/yaml/nodes/severity"

      def self.[](key)
        return key if key.respond_to? :new
        name = constants.detect { |c| c.downcase == key }
        raise ArgumentError, "unknown node type %p" % key unless name
        const_get(name)
      end
    end
  end
end
