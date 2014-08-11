require 'thor'
require_relative 'command'

module Permpress
  # CSS Lint subcommand. Calls CSS Lint with the correct arguments.
  class CSSLint < Thor
    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('csslint', files, flags).run
    end

  private

    def flags
      [
        "--errors=#{RULES}",
        '--format=compact'
      ].tap do |flags|
        flags.concat(["--config=#{options[:config]}"]) if options[:config]
      end
    end

    RULES = %w(
      important
      adjoining-classes
      known-properties
      box-sizing
      box-model
      overqualified-elements
      display-property-grouping
      bulletproof-font-face
      compatible-vendor-prefixes
      regex-selectors
      errors
      duplicate-background-images
      duplicate-properties
      empty-rules
      selector-max-approaching
      gradients
      fallback-colors
      font-sizes
      font-faces
      floats
      star-property-hack
      outline-none
      import
      ids
      underscore-property-hack
      rules-count
      qualified-headings
      selector-max
      shorthand
      text-indent
      unique-headings
      universal-selector
      unqualified-attributes
      vendor-prefix
      zero-units
    ).join(',')
  end
end
