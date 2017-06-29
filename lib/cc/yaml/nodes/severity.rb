module CC
  module Yaml
    module Nodes
      class Severity < Scalar
        SEVERITIES = [
          "info".freeze,
          "minor".freeze,
          "major".freeze,
          "critical".freeze,
          "blocker".freeze
        ].freeze

        def value=(value)
          unless value.nil?
            normalized_value = value.to_s.strip.downcase
            if SEVERITIES.include? normalized_value
              @value = normalized_value
            else
              error("Unexpected severity %s", value.inspect)
            end
          end
        end
      end
    end
  end
end
