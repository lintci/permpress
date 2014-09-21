require 'thor'

require_relative 'rubocop'
require_relative 'jshint'
require_relative 'jslint'
require_relative 'coffeelint'
require_relative 'golint'
require_relative 'govet'
require_relative 'checkstyle'
require_relative 'csslint'
require_relative 'scsslint'
require_relative 'jsonlint'
require_relative 'pylint'
require_relative 'cppcheck'

module Permpress
  # Main CLI that controls all other linters
  class CLI < Thor
    # Ruby
    register Permpress::RuboCop, 'rubocop', 'rubocop', 'Invokes Rubocop'

    # JS
    register Permpress::JSHint, 'jshint', 'jshint', 'Invokes JSHint'
    # register Permpress::JSLint, 'jslint', 'jslint', 'Invokes JSLint'

    # CoffeeScript
    register Permpress::CoffeeLint, 'coffeelint', 'coffeelint', 'Invokes coffeelint'

    # Go
    register Permpress::GoLint, 'golint', 'golint', 'Invokes golint'
    # register Permpress::GoVet, 'govet', 'govet', 'Invokes go vet'

    # Java
    register Permpress::Checkstyle, 'checkstyle', 'checkstyle', 'Invokes Checkstyle'

    # CSS
    register Permpress::CSSLint, 'csslint', 'csslint', 'Invokes csslint'

    # SCSS
    register Permpress::SCSSLint, 'scsslint', 'scsslint', 'Invokes scss-lint'

    # JSON
    register Permpress::JSONLint, 'jsonlint', 'jsonlint', 'Invokes durable-json-lint'

    #PyLint
    register Permpress::PyLint, 'pylint', 'pylint', 'Invokes PyLint'

    #CppCheck
    register Permpress::CppCheck, 'cppcheck', 'cppcheck', 'Invokes CppCheck'

  end
end
