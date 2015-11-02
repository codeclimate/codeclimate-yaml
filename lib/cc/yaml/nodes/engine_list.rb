module CC
  module Yaml
    module Nodes
      class EngineList < OpenMapping
        GENERIC_ERROR_MESSAGE = "The engines key should be a mapping from engine name to engine config.".freeze

        default_type Engine

        def visit_unexpected(_visitor, _value, message = nil)
          if message
            message = "#{message}. #{ERROR_MESSAGE}"
          else
            message = ERROR_MESSAGE
          end
          error(message)
        end
      end
    end
  end
end
