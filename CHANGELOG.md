#### Git

- FIX: don't raise an exception when attempting to assign to a mapped node

#### 0.2.1 - July 29, 2015

- FIX: Having both a languages and engines key is now considered a warning, not
  an error
- DOCS: Add changelog

#### 0.2.0 - July 24, 2015

- FIX: Normalize recursive glob paths in `exclude_paths` and `ratings` to have
  form `app/**/*` and `**/*.rb` (not `app/**` or `**.rb`)
- BREAKING: No longer support `#exclude?` and `#rate?` methods on `root`

#### 0.1.1 - July 23, 2015

- FEATURE: Support enabling and disabling checks for engines:
  `engines.<name>.checks.<name>.enabled`:

  ```yaml
  engines:
    rubocop:
      enabled: true
      checks:
        Style/StringLiteral:
          enabled: false
  ```

#### 0.1.0 - July 23, 2015

- FIX: Remove custom JSON serialization

#### 0.0.10 - July 20, 2015

- FIX: Treat analysis key errors as `errors` instead of `warnings`

#### 0.0.8 - July 16, 2015

- FIX: Clarify warning message when `engines` and `languages` keys
  simultaneously present.
- FEATURE: Warn when no `languages` or `engines` key is found.

#### 0.0.7 - July 13, 2015

- FIX: `languages` key expects to take a map of scalar values:

  ```yaml
  languages:
      Ruby: true
      JavaScript: true
      PHP: true
      Python: true
  ```

#### 0.0.1 - June 8, 2015

Initial public release
