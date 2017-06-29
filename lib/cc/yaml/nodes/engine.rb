module CC
  module Yaml
    module Nodes
      class Engine < Mapping
        DEFAULT_CHANNEL = "stable".freeze

        map :enabled, to: Scalar[:bool], required: true
        map :channel, to: Scalar
        map :checks, to: Checks
        map :config, to: EngineConfig
        map :exclude_fingerprints, to: Sequence
        map :exclude_paths, to: GlobList
        map :issue_override, to: IssueOverride

        def channel
          self["channel"] || DEFAULT_CHANNEL
        end
      end
    end
  end
end
