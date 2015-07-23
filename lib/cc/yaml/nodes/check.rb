module CC
  module Yaml
    module Nodes
      class Check < Mapping
        map :enabled, to: Scalar[:bool], required: true
      end
    end
  end
end
