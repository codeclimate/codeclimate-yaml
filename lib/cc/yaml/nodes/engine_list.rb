module CC
  module Yaml
    module Nodes
      class EngineList < OpenMapping
        GENERIC_ERROR_MESSAGE = "The engines key should be a mapping from engine name to engine config.".freeze
        EMPTY_ERROR_MESSAGE = "The engines key cannot be empty.".freeze

        default_type Engine

        def verify
          super
          verify_not_empty
        end

        def visit_unexpected(_visitor, _value, message = nil)
          if message
            message = message << ". #{GENERIC_ERROR_MESSAGE}"
          else
            message = GENERIC_ERROR_MESSAGE
          end
          error(message)
        end

        private

        def verify_not_empty
          error(EMPTY_ERROR_MESSAGE) if mapping.keys.empty? && errors.empty?
        end
      end
    end
  end
end
