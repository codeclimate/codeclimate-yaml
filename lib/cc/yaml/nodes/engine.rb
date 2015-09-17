module CC
  module Yaml
    module Nodes
      class Engine < Mapping
        map :enabled, to: Scalar[:bool], required: true
        map :checks, to: Checks
        map :config, to: EngineConfig

        def config
          self[:config].__getobj__
        end
      end
    end
  end
end
