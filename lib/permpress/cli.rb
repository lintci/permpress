require 'thor'

require_relative 'rubocop'
require_relative 'jshint'
require_relative 'jslint'
require_relative 'coffeelint'
require_relative 'golint'
require_relative 'govet'
require_relative 'csslint'
require_relative 'scsslint'
require_relative 'jsonlint'

module Permpress
  class CLI < Thor
    # Ruby
    register Permpress::RuboCop, 'rubocop', 'rubocop', 'Invokes Rubocop'

    # JS
    register Permpress::JSHint, 'jshint', 'jshint', 'Invokes JSHint'
    register Permpress::JSLint, 'jslint', 'jslint', 'Invokes JSLint'

    # CoffeeScript
    register Permpress::CoffeeLint, 'coffeelint', 'coffeelint', 'Invokes coffeelint'

    # Go
    register Permpress::GoLint, 'golint', 'golint', 'Invokes golint'
    register Permpress::GoVet, 'govet', 'govet', 'Invokes go vet'

    # CSS
    register Permpress::CSSLint, 'csslint', 'csslint', 'Invokes csslint'

    # SCSS
    register Permpress::SCSSLint, 'scsslint', 'scsslint', 'Invokes scss-lint'

    # JSON
    register Permpress::JSONLint, 'jsonlint', 'jsonlint', 'Invokes durable-json-lint'
  end
end
