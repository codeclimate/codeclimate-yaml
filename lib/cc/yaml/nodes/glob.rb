module CC
  module Yaml
    module Nodes
      class Glob < Scalar
        def to_s
          value
        end

        def value
          # normalize glob format: app/** => app/**/* and **.rb => **/*.rb
          @value && @value.sub(%r{\*\*([^\/]*)?$}, "**/*\\1")
        end
      end
    end
  end
end
