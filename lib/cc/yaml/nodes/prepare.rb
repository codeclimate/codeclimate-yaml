module CC
  module Yaml
    module Nodes
      class Prepare < Mapping
        map :fetch_files, to: FetchList
      end
    end
  end
end
