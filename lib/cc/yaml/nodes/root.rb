module CC
  module Yaml
    module Nodes
      class Root < Mapping
        map :exclude_paths, to: ExcludePathList
        map :engines, to: EngineList

        def initialize
          super(nil)
        end

        def nested_warnings(*)
          super.uniq
        end

        def inspect
          "#<#{self.class.name}:#{super}>"
        end
      end
    end
  end
end
