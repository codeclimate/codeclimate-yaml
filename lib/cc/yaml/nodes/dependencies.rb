module CC
  module Yaml
    module Nodes
      class Dependencies < Mapping
        map :files, to: FileDependencyList
      end
    end
  end
end
