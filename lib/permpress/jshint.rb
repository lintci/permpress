require 'thor'
require_relative 'command'

module Permpress
  class JSHint < Thor
    FORMATTER_PATH = File.expand_path('../jshint/formatter.js', __FILE__)

    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('jshint', files, flags).run
    end

  private

    def flags
      ['--reporter', FORMATTER_PATH].tap do |flags|
        flags.concat(['--config', options[:config]]) if options[:config]
      end
    end
  end
end
