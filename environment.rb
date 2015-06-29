paths = Dir["lib/**/*.rb"].reverse
paths.each do |path|
  require File.expand_path(path)
end
