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
      %w(
        -r no
        --msg-template "{abspath}:{line}:{column}::{symbol}:{category}:{msg}"
      ).tap do |flags|
        flags.concat(['--rcfile', options[:config]]) if options[:config]
      end
    end
  end
end
