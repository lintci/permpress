require 'thor'
require_relative 'command'

module Permpress
  # CoffeLint subcommand. Calls CoffeeLint with correct arguments.
  class CoffeeLint < Thor
    FORMATTER_PATH = File.expand_path('../coffeelint/lintci.coffee', __FILE__)

    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('coffeelint', files, flags).run
    end

  private

    def flags
      [
        "--reporter=#{FORMATTER_PATH}",
        '--nocolor'
      ].tap do |flags|
        flags.concat(["--file=#{options[:config]}"]) if options[:config]
      end
    end
  end
end
