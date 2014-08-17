require 'thor'
require_relative 'command'

module Permpress
  # Checkstyle subcommand. Calls Checkstyle with correct arguments.
  class Checkstyle < Thor
    JAR = File.expand_path('../checkstyle/checkstyle_logger-all.jar', __FILE__)
    DEFAULT_CONFIG = File.expand_path('../checkstyle/sun_checks.xml', __FILE__)

    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('java', files, flags).run
    end

  private

    def flags
      [
        '-jar', JAR,
        '-c', options[:config] || DEFAULT_CONFIG
      ]
    end
  end
end
