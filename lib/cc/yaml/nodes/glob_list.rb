module CC
  module Yaml
    module Nodes
      class GlobList < Sequence
        type Glob

        def match_any?(path)
          any? { |g| g.match?(path) }
        end
      end
    end
  end
end
