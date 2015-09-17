module CC
  module Yaml
    module Nodes
      class Engine < Mapping
        map :enabled, to: Scalar[:bool], required: true
        map :checks, to: Checks
        map :config, to: Mapping

        attr_reader :config

        def visit_key_value(visitor, key, value)
          if key == "config"
            raw_value = value.to_ruby

            # backwards compatability for phpcodesniffer
            if raw_value.is_a?(String)
              @config = { "file" => raw_value }
            else
              @config = raw_value
            end
          else
            super
          end
        end
      end
    end
  end
end
