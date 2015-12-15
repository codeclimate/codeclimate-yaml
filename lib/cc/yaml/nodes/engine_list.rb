module CC
  module Yaml
    module Nodes
      class EngineList < OpenMapping
        GENERIC_ERROR_MESSAGE = "The engines key should be a mapping from engine name to engine config.".freeze
        EMPTY_ERROR_MESSAGE = "The engines key cannot be empty.".freeze
        NO_ENABLED_ERROR_MESSAGE = "No engines are enabled, so no analysis can be run.".freeze

        default_type Engine

        def verify
          super
          verify_not_empty
          verify_enabled
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
          error(EMPTY_ERROR_MESSAGE) if errors.empty? && mapping.keys.empty?
        end

        def verify_enabled
          error(NO_ENABLED_ERROR_MESSAGE) if errors.empty? && !mapping.values.map(&:enabled).include?(true)
        end
      end
    end
  end
end
