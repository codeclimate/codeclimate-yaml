module CC
  module Yaml
    module Nodes
      class Glob < Scalar
        def value
          @value.sub(%r{\*\*\.}, "**/*.").sub(%r{\/\*\*$}, "/**/*")
        end
      end
    end
  end
end
