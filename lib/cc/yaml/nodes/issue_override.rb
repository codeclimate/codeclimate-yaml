module CC
  module Yaml
    module Nodes
      class IssueOverride < Mapping
        map :severity, to: Severity
      end
    end
  end
end
