module CC
  module Yaml
    module Nodes
      class LanguageList < Mapping
        %w[Ruby JavaScript Python PHP].each do |language|
          map :"#{language}", to: Scalar[:bool], required: false
        end
      end
    end
  end
end
