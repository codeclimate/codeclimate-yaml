module CC
  module Yaml
    module Nodes
      class Prepare < Mapping
        map :fetch, to: FetchList
      end
    end
  end
end
