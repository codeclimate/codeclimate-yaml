module CC
  module Yaml
    module Nodes
      class LanguageList < Mapping
        LANGUAGES = %w[Ruby JavaScript Python PHP].freeze

        LANGUAGES.each do |language|
          map :"#{language}", to: Scalar[:bool], required: false
        end
      end
    end
  end
end
