require 'thor'
require_relative 'command'

module Permpress
  # Rubocop subcommand. Calls Rubocop with correct arguments.
  class PyLint < Thor

    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('pylint', files, flags).run
    end

  private

    def flags
      [
        '-r', 'no',
        '-f', 'parseable',
      ].tap do |flags|
        flags.concat(['--rcfile', options[:config]]) if options[:config]
      end
    end
  end
end
