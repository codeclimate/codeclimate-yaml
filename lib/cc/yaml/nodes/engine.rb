module CC
  module Yaml
    module Nodes
      class Engine < Mapping
        map :enabled, to: Scalar[:bool], required: true
        map :checks, to: Checks
        map :config, to: EngineConfig
        map :ignored_issues, to: Sequence
      end
    end
  end
end
