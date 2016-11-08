module CC::Yaml
  module Nodes
    class OpenMapping < Mapping
      def self.default_type(identifier = nil)
        @default_type = Nodes[identifier] if identifier
        @default_type ||= superclass.respond_to?(:default_type) ? superclass.default_type : nil
      end

      def subnode_for(visitor, key, value)
        klass = self.class.subnode_for_key(key) || self.class.default_type || visitor.node_wrapper_class(value)
        klass.new(self)
      end

      def accept_key?(key)
        true
      end
    end
  end
end
