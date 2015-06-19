module CC
  module Yaml
    module Nodes
      class Glob < Scalar
        def match?(path)
          File.fnmatch(to_s, path)
        end
      end
    end
  end
end
