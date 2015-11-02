module CC
  module Yaml
    module Nodes
      class EngineList < OpenMapping
        ERROR_MESSAGE="foo"

        default_type Engine

        def visit_unexpected(visitor, value, message = nil)
          error(ERROR_MESSAGE)
        end
      end
    end
  end
end
