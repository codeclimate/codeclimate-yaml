module CC
  module Yaml
    module Nodes
      class NestedConfig < OpenMapping
        def visit_key_value(visitor, key, value)
          node = subnode_for_pair(visitor, key, value)
          assign_node_and_visit(node, key, value, visitor)
        end

        protected

        def subnode_for_pair(visitor, key, value)
          if value.is_a?(::Psych::Nodes::Mapping)
            NestedConfig.new(self)
          elsif value.is_a?(::Psych::Nodes::Sequence)
            Sequence.new(self)
          else
            subnode_for(visitor, key, value)
          end
        end
      end
    end
  end
end
