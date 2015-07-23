module CC
  module Yaml
    module Nodes
      class Ratings < Mapping
        map :paths, to: GlobList
      end
    end
  end
end
