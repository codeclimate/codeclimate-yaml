module CC::Yaml
  module Nodes
    class Mapping < Node
      INCOMPATIBLE_KEYS_WARNING = "Use either a Languages key or an Engines key, but not both. They are mutually exclusive.".freeze

      def self.mapping
        @mapping ||= superclass.respond_to?(:mapping) ? superclass.mapping.dup : {}
      end

      def self.required
        @required ||= superclass.respond_to?(:required) ? superclass.required.dup : []
      end

      def self.aliases
        @aliases ||= superclass.respond_to?(:aliases) ? superclass.aliases.dup : {}
      end

      def self.map(*list)
        options = Hash === list.last ? list.pop : {}
        list.each do |key|
          required     << key.to_s if options[:required]
          define_map_accessor(key)
          case options[:to]
          when Symbol then aliases[key.to_s] = options[:to].to_s
          when Module then mapping[key.to_s] = options[:to]
          when nil    then mapping[key.to_s] = Nodes[key]
          else raise ArgumentError, 'unexpected value for to: %p' % options[:to]
          end
        end
      end

      def self.define_map_accessor(key)
        define_method(key)       { | | self[key]       } unless method_defined? key
        define_method("#{key}=") { |v| self[key] = v   } unless method_defined? "#{key}="
        define_method("#{key}?") { | | !!self[key]     } unless method_defined? "#{key}?"
      end

      def self.subnode_for(key)
        mapping[aliases.fetch(key.to_s, key.to_s)]
      end

      attr_reader :mapping
      alias_method :__getobj__, :mapping

      def prepare
        @mapping = {}
        super
      end

      def visit_mapping(visitor, value)
        visitor.apply_mapping(self, value)
      end

      def visit_pair(visitor, key, value)
        key = visitor.generate_key(self, key)
        unless set_warnings(key)
          check_incompatibility(key)
          visit_key_value(visitor, key, value)
        end
      end

      def visit_key_value(visitor, key, value)
        node = subnode_for(key)
        self[key] = node
        visitor.accept(node, value)
      end

      def set_warnings(key)
        if subnode_for(key)
          check_duplicates(key)
        else
          warning("unexpected key %p, dropping", key)
        end
      end

      def []=(key, value)
        if mapped_key = mapped_key(key)
          @mapping[mapped_key] = value
        else
          warning("unexpected key %p, dropping", key)
        end
      end

      def [](key)
        @mapping[mapped_key(key)]
      end

      def include?(key)
        @mapping.include? mapped_key(key)
      end

      def empty?
        @mapping.empty?
      end

      def mapped_key(key)
        key = self.class.aliases.fetch(key.to_s, key.to_s)
        key if accept_key?(key)
      end

      def accept_key?(key)
        self.class.mapping.include? key
      end

      def subnode_for(key)
        type = self.class.subnode_for(key)
        type.new(self) if type
      end

      def inspect
        @mapping.inspect
      end

      def ==(other)
        other = other.mapping if other.is_a? Mapping
        if other.respond_to? :to_hash and other.to_hash.size == @mapping.size
          other.to_hash.all? { |k, v| include?(k) and self[k] == v }
        else
          false
        end
      end

      def verify
        verify_errors
        verify_required
        verify_errors
      end

      def verify_required
        self.class.required.each do |key|
          next if @mapping.include? key
          type = self.class.subnode_for(key)
          if type.has_default?
            warning "missing key %p, defaulting to %p", key, type.default
            @mapping[key] = type.new(self)
          else
            error "missing key %p", key
          end
        end
      end

      def verify_errors
        @mapping.delete_if do |key, value|
          if value.errors?
            warning "dropping %p section: %s", key, value.errors.join(', ')
            true
          end
        end
      end

      def deep_verify
        @mapping.each_value(&:deep_verify)
        super
      end

      def nested_warnings(*prefix)
        @mapping.inject(super) do |list, (key, value)|
          list = value.nested_warnings(*prefix, key) + list
        end
      end

      def with_value!(value)
        value = value.mapping while value.is_a? Mapping
        value.each { |key, value| self[key] = value }
      end

      def each_scalar(type = nil, &block)
        return enum_for(:each_scalar, type) unless block
        @mapping.each_value { |v| v.each_scalar(type, &block) }
      end

      protected

      def dup_values
        duped_mapping = @mapping.map { |key, value| [key.dup, value.dup] }
        @mapping      = Hash[duped_mapping]
        self
      end

      def check_duplicates(key)
        warning("has multiple %p entries, keeping last entry", key) if self[key]
      end

      def check_incompatibility(key)
        if creates_incompatibility?(key)
          warning INCOMPATIBLE_KEYS_WARNING
        end
      end

      def creates_incompatibility?(key)
        (key == "engines" && self["languages"]) || (key == "languages" && self["engines"])
      end
    end
  end
end
