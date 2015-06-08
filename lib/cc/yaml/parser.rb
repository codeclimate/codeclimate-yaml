module CC
  module Yaml
    module Parser
      autoload :Psych, "cc/yaml/parser/psych"

      def self.parse(value)
        Psych.parse(value)
      end
    end
  end
end
