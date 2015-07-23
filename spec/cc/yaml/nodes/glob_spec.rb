require "spec_helper"

describe CC::Yaml::Nodes::Glob do
  def setup
    CC::Yaml::Nodes::Root.class_eval do
      map :example, to: CC::Yaml::Nodes::GlobList
    end
  end

  it "normalizes value for paths ending in 'directory/**'" do
    example = parse_example(<<-EOYAML)
      example:
      - foo/**
      - bar/**
      - foo/bar/**
      - okay/**/*
    EOYAML

    example.must_equal([
      "foo/**/*",
      "bar/**/*",
      "foo/bar/**/*",
      "okay/**/*"
      ])
  end

  it "normalizes value for paths beginning '**.extension'" do
    example = parse_example(<<-EOYAML)
      example:
      - "**.rb"
      - "**/*.jsx"
      - "**.html.slim"
      - "test/**/models/**.rb"
    EOYAML

    example.must_equal([
      "**/*.rb",
      "**/*.jsx",
      "**/*.html.slim",
      "test/**/models/**/*.rb"
      ])
  end

  it "doesn't alter .extension paths that don't begin '**.extension'" do
    unchanged = parse_example(<<-EOYAML)
      example:
      - "**/*.rb"
      - "*.js"
      - ".codeclimate.yml"
      - ".go"
    EOYAML

    unchanged.must_equal([
      "**/*.rb",
      "*.js",
      ".codeclimate.yml",
      ".go"
      ])
  end

  it "doesn't alter directory paths not ending in 'directory/**'" do
    unchanged = parse_example(<<-EOYAML)
      example:
      - "app/**/*"
      - "foo/bar/**/*"
      - "lib/*"
      - "spec/*.rb"
      - "test/**/models/*.rb"
    EOYAML

    unchanged.must_equal([
      "app/**/*",
      "foo/bar/**/*",
      "lib/*",
      "spec/*.rb",
      "test/**/models/*.rb"
      ])
  end

  it "returns same value when paths are correctly formatted" do
    already_correct = parse_example(<<-EOYAML)
      example:
      - "**/*.rb"
      - "**/*.js"
      - app/**/*
      - foo/bar/**/*
      - lib/foo/**/*.rb
    EOYAML

    already_correct.must_equal([
      "**/*.rb",
      "**/*.js",
      "app/**/*",
      "foo/bar/**/*",
      "lib/foo/**/*.rb"
      ])
  end

  def parse_example(yaml)
    CC::Yaml.parse(yaml).example
  end
end
