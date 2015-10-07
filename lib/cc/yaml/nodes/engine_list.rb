module CC
  module Yaml
    module Nodes
      class EngineList < OpenMapping
        default_type Engine

        def add(engine_name, value)
          self[engine_name] = Engine.new(self).with_value(value)
        end
      end
    end
  end
end
