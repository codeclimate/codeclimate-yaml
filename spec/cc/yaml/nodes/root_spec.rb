require "spec_helper"

module CC::Yaml::Nodes
  describe Root do
    describe "#exclude?" do
      it "returns false if no exclude paths exist" do
        root = CC::Yaml.parse!("")

        root.exclude?("foo.rb").must_equal(false)
      end

      it "returns true only if any exclude paths match" do
        root = CC::Yaml.parse!(<<-EOYAML)
          exclude_paths:
            - spec/**
            - vendor/**
        EOYAML

        root.exclude?("foo.rb").must_equal(false)
        root.exclude?("spec/foo.rb").must_equal(true)
        root.exclude?("vendor/foo.rb").must_equal(true)
      end
    end

    describe "#rate?" do
      it "returns false if no ratings exist" do
        root = CC::Yaml.parse!("")

        root.rate?("foo.rb").must_equal(false)
      end
    end
  end
end
