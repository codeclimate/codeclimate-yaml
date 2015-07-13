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

        def exclude?(path)
          exclude_paths.present? && exclude_paths.match_any?(path)
        end

        def rate?(path)
          ratings.present? && ratings.rate?(path)
        end
      end
    end
  end
end
