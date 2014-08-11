require 'thor'
require_relative 'command'

module Permpress
  # SCSS Lint subcommand. Calls SCSS Lint with the correct arguments.
  class SCSSLint < Thor
    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    PROGRAM = File.expand_path('../scsslint/scsslint', __FILE__)

    def lint(*files)
      Command.new(PROGRAM, files, flags).run
    end

  private

    def flags
      ['--format=LintCI'].tap do |flags|
        flags.concat(["--config=#{options[:config]}"]) if options[:config]
      end
    end
  end
end
