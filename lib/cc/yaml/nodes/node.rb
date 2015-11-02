module CC
  module Yaml
    module Nodes
      class Node
        def self.has_default?
          false
        end

        attr_accessor :parent

        def initialize(parent)
          @nested_warnings = []
          @parent          = parent
          prepare
          yield self if block_given?
        end

        def warnings?
          warnings.any?
        end

        def errors?
          errors.any?
        end

        def warnings
          @warnings ||= []
        end

        def nested_warning(message, *prefix)
          @nested_warnings << [prefix, message]
        end

        def nested_warnings(*prefix)
          messages  = errors + warnings
          prefixed  = messages.map { |warning| [prefix, warning] }
          prefixed += @nested_warnings.map { |p, w| [prefix + p, w] }
          prefixed
        end

        def errors
          @errors ||= []
        end

        def warning(message, *params)
          warnings << message % params
        end

        def error(message, *params)
          errors << message % params
        end

        def prepare
        end

        def verify
        end

        def deep_verify
          verify
        end

        def visit_unexpected(visitor, value, message = nil)
          error(message || "unexpected %p", value)
        end

        def visit_mapping(visitor, value)
          visit_unexpected(visitor, value, "unexpected mapping")
        end

        def visit_pair(visitor, key, value)
          visit_unexpected(visitor, value, "unexpected pair")
        end

        def visit_scalar(visitor, type, value, implicit = true)
          visit_unexpected(visitor, value, "unexpected scalar") unless type == :null
        end

        def visit_sequence(visitor, value)
          visit_unexpected(visitor, value, "unexpected sequence")
        end

        def visit_child(visitor, value)
          visit_unexpected(visitor, value, "unexpected child")
        end

        def respond_to_missing?(method, include_private = false)
          __getobj__.respond_to?(method, false)
        end

        def method_missing(method, *args, &block)
          return super unless __getobj__.respond_to?(method)
          __getobj__.public_send(method, *args, &block)
        end

        def to_s
          __getobj__.to_s
        end

        def as_json(options = nil)
          __getobj__.as_json(options)
        end

        def with_value(value)
          node = dup
          node.with_value!(value)
          node
        end

        def dup
          super.dup_values
        end

        protected

          def dup_values
            self
          end
      end
    end
  end
end
