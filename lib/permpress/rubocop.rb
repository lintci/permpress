require 'thor'
require_relative 'command'

module Permpress
  class RuboCop < Thor
    FORMATTER_PATH = File.expand_path('../rubocop/formatter.rb', __FILE__)

    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('rubocop', files, flags).run
    end

  private

    def flags
      [
        '--require', FORMATTER_PATH,
        '--format', 'Permpress::Rubocop::Formatter',
        '--no-color'
      ].tap do |flags|
        flags.concat(['--config', options[:config]]) if options[:config]
      end
    end
  end
end
