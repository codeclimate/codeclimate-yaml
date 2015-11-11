module CC
  module Yaml
    module Nodes
      class Engine < Mapping
        map :enabled, to: Scalar[:bool], required: true
        map :checks, to: Checks
        map :config, to: EngineConfig
        map :exclude_fingerprints, to: Sequence
        map :exclude_paths, to: GlobList
      end
    end
  end
end
