module CC
  module Yaml
    module Nodes
      class Engine < Mapping
        map :enabled, to: Scalar[:bool], required: true
        map :checks, to: Checks
      end
    end
  end
end
