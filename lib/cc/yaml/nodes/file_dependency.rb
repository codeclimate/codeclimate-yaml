require "uri"
require "pathname"

module CC
  module Yaml
    module Nodes
      class FileDependency < Mapping
        INVALID_URL_ERROR = "invalid URL: %s".freeze
        EMPTY_PATH_ERROR = "path cannot be empty".freeze
        ABSOLUTE_PATH_ERROR = "absolute path \"%s\" is invalid".freeze
        PARENT_PATH_ERROR = "relative path elements in \"%s\" are invalid: use \"%s\" instead".freeze

        map :url, to: Scalar[:str], required: true
        map :path, to: Scalar[:str], required: true

        def visit_scalar(_visitor, type, value_node, _implicit = true)
          if type == :str
            if valid_url?(value_node.value)
              self.url = url_node_from_url(value_node.value)
            else
              error(format(INVALID_URL_ERROR, value_node.value))
            end
          else
            super
          end
        end

        def verify
          if !url.nil? && path.nil?
            self.path = path_node_from_url(url.value)
          end
          error(format(INVALID_URL_ERROR, url.value)) if url && !valid_url?(url.value)
          validate_path(path.value) if path
          super
        end

        private

        def valid_url?(url)
          uri = URI.parse(url)
          uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
        rescue URI::InvalidUriError
          false
        end

        def validate_path(path)
          if path.nil? || path.length.zero?
            return error(EMPTY_PATH_ERROR)
          end

          pathname = Pathname.new(path)
          if pathname.absolute?
            error(format(ABSOLUTE_PATH_ERROR, path))
          end
          if pathname.cleanpath.to_s != pathname.to_s || path.include?("..")
            error(format(PARENT_PATH_ERROR, path, pathname.cleanpath.to_s))
          end
        end

        def url_node_from_url(url)
          node = Scalar.new(self)
          node.value = url
          node
        end

        def path_node_from_url(url)
          node = Scalar.new(self)
          node.value = File.basename(URI.parse(url).path)
          node
        end
      end
    end
  end
end
