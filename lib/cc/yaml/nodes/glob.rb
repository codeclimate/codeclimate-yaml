module CC
  module Yaml
    module Nodes
      class Glob < Scalar
        def value
          @value.sub(%r{\*\*([^\/]*)?$}, "**/*\\1") # normalize glob format: app/** => app/**/* and **.rb => **/*.rb
        end
      end
    end
  end
end
