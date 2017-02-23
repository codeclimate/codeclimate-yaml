module CC
  module Yaml
    module Nodes
      class GlobList < Sequence
        type Glob

        def allow_child?(child)
          !child.value.nil?
        end
      end
    end
  end
end
