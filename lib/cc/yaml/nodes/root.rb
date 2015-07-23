require "active_support"
require "active_support/core_ext"

module CC
  module Yaml
    module Nodes
      class Root < Mapping
        map :engines, to: EngineList
        map :exclude_paths, to: GlobList
        map :languages, to: LanguageList
        map :ratings, to: Ratings

        def initialize
          super(nil)
        end

        def nested_warnings(*)
          super.uniq
        end

        def inspect
          "#<#{self.class.name}:#{super}>"
        end
      end
    end
  end
end
