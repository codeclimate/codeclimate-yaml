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
        root.exclude?("spec/test/foo.rb").must_equal(true)
        root.exclude?("vendor/foo.rb").must_equal(true)
      end

      it "expects directory paths to be formatted app/**" do
        root = CC::Yaml.parse!(<<-EOYAML)
          exclude_paths:
            - spec/**/*
            - vendor/**
        EOYAML

        root.exclude?("spec/test/foo.rb").must_equal(true)
        root.exclude?("spec/foo.rb").must_equal(false)
        root.exclude?("vendor/foo.rb").must_equal(true)
        root.exclude?("vendor/javascripts/foo.js").must_equal(true)
      end
    end

    describe "#rate?" do
      it "returns false if no ratings exist" do
        root = CC::Yaml.parse!("")

        root.rate?("foo.rb").must_equal(false)
      end

      it "returns false if the path is excluded" do
        root = CC::Yaml.parse(<<-EOYAML)
          engines:
            eslint:
              enabled: true
          ratings:
            paths:
            - app/**
            - lib/**
          exclude_paths:
          - spec/**/*
          - tmp/**/*
          - app/assets/javascripts/**
          - app/assets/stylesheets/**
        EOYAML

        root.rate?("app/foo/bar.rb").must_equal(true)
        root.rate?("app/foo/bar.js").must_equal(true)
        root.rate?("lib/foo.rb").must_equal(true)
        root.exclude?("app/assets/stylesheets/bar.css").must_equal(true)
        root.rate?("app/assets/stylesheets/bar.css").must_equal(false)
        root.rate?("app/assets/javascripts/bar.js").must_equal(false)
        root.rate?("README.md").must_equal(false)
      end
    end
  end
end
