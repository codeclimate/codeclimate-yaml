module CC
  module Yaml
    module Nodes
      class Ratings < Mapping
        map :paths, to: GlobList

        def rate?(path)
          paths.present? && paths.match_any?(path)
        end
      end
    end
  end
end
