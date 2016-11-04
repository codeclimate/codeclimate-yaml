module CC
  module Yaml
    module Nodes
      class Dependencies < OpenMapping
        map :files, to: FileDependencyList
      end
    end
  end
end
