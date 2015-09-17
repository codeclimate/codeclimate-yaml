module CC::Yaml
  module Nodes
    class OpenMapping < Mapping
      def self.default_type(identifier = nil)
        @default_type = Nodes[identifier] if identifier
        @default_type ||= superclass.respond_to?(:default_type) ? superclass.default_type : Scalar
      end

      # def self.subnode_for(key, identifier = nil)
      #   super(key) || default_type(identifier)
      # end
      def self.subnode_for(key)
        super(key) || default_type
      end

      def accept_key?(key)
        true
      end

      # def visit_mapping(visitor, value)
      #   p value
      #   raise "mapping"
      #   visitor.apply_mapping(self, value)
      # end

      def visit_pair(visitor, key, value)
        p key.class
        p value.class
        raise "pair"
        key = visitor.generate_key(self, key)
        unless set_warnings(key)
          check_incompatibility(key)
          visit_key_value(visitor, key, value)
        end
      end

      def visit_key_value(visitor, key, value)
        raise "kv"
      end

      # def visit_child(visitor, value)
      #   raise "unexpected"
      #   p value
      # end
      # def visit_key_value(visitor, key, value)
      #   if value.is_a?(Hash)
      #     node = subnode_for(key, OpenMapping)
      #   else
      #     node = subnode_for(key)
      #   end

      #   p key
      #   p value
      #   #p node

      #   self[key] = node
      #   visitor.accept(node, value)
      # end

      # def subnode_for(key, identifier = nil)
      #   type = self.class.subnode_for(key, identifier)
      #   type.new(self) if type
      # end
    end
  end
end
