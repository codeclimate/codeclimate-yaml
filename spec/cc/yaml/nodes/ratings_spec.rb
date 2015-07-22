require "spec_helper"

module CC::Yaml::Nodes
  describe Ratings do
    def setup
      Root.class_eval do
        map :example, to: Ratings
      end
    end

    describe "#rate?" do
      it "returns false if paths exist" do
        ratings = parse_example(<<-EOYAML)
          example:
            paths:
        EOYAML

        ratings.rate?("foo.rb").must_equal(false)
      end

      it "returns true only if any paths match" do
        ratings = parse_example(<<-EOYAML)
          example:
            paths:
              - app/**.rb
              - app/**.js
              - lib/**.rb
        EOYAML

        ratings.rate?("app/foo/bar.rb").must_equal(true)
        ratings.rate?("app/foo/bar.js").must_equal(true)
        ratings.rate?("lib/foo.rb").must_equal(true)
        ratings.rate?("spec/foo_spec.rb").must_equal(false)
        ratings.rate?("README.md").must_equal(false)
      end

      it "expects directory paths to be formatted app/**" do
        ratings = parse_example(<<-EOYAML)
          example:
            paths:
              - app/**
              - lib/**
              - "**.js"
        EOYAML

        ratings.rate?("app/foo/bar.rb").must_equal(true)
        ratings.rate?("app/bar.rb").must_equal(true)
        ratings.rate?("lib/foo/bar.rb").must_equal(true)
        ratings.rate?("lib/foo.rb").must_equal(true)
        ratings.rate?("assets/foo.js").must_equal(true)
        ratings.rate?("README.md").must_equal(false)
      end

      it "fails to catch all paths in directory when format is app/**/*" do
        ratings = parse_example(<<-EOYAML)
          example:
            paths:
              - app/**/*
              - lib/**/*
        EOYAML

        ratings.rate?("app/foo/bar.rb").must_equal(true)
        ratings.rate?("app/bar.rb").must_equal(false)
        ratings.rate?("lib/foo/bar.rb").must_equal(true)
        ratings.rate?("lib/foo.rb").must_equal(false)
      end
    end

    def parse_example(yaml)
      CC::Yaml.parse(yaml).example
    end
  end
end
