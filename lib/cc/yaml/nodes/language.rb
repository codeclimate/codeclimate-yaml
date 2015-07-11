module CC
  module Yaml
    module Nodes
      class Language < Scalar
        LANGUAGES = %w[Ruby JavaScript Python PHP].freeze

        def valid?
          LANGUAGES.include?(name)
        end

        def name
          self.to_s
        end

        def appears_to_be_mispelled_version_of?
          if !valid? && downcased_language_map.has_key?(name.downcase)
            downcased_language_map[self]
          else
            false
          end
        end

        def downcased_language_map
          @downcased_language_map ||=
          begin
            LANGUAGES.each_with_object({}) do |language, obj|
              obj[language.downcase] = language
            end
          end
        end
      end
    end
  end
end
