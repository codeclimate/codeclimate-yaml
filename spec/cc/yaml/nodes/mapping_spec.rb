require "spec_helper"

describe CC::Yaml::Nodes::Mapping do
  describe "#[]" do
    it "returns value in mapping" do
      config = CC::Yaml.parse <<-YAML
        languages:
          Ruby: false
          JavaScript: true
          Python: true
      YAML

      config.languages["Ruby"].value.must_equal false
    end
  end

  describe "#[]=" do
    it "updates values in mapping" do
      config = CC::Yaml.parse <<-YAML
        languages:
          Ruby: true
          JavaScript: false
          Python: false
      YAML

      config.languages.must_equal({ "Ruby" => true, "JavaScript" => false, "Python" => false })
      config.languages["JavaScript"].value.must_equal false

      config.languages["JavaScript"] = true

      config.languages["JavaScript"].value.must_equal true
      config.languages.must_equal({ "Ruby" => true, "JavaScript" => true, "Python" => false })
    end

    it "updates values in mapping" do
      config = CC::Yaml.parse <<-YAML
        languages:
          Ruby: true
          JavaScript: true
          Python: false
      YAML
      config.languages.must_equal({ "Ruby" => true, "JavaScript" => true, "Python" => false })
      config.languages["PHP"] = true

      config.languages["PHP"].value.must_equal true
      config.languages.must_equal({ "Ruby" => true, "JavaScript" => true, "Python" => false, "PHP" => true })
    end
  end
end
