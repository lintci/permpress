require 'thor'
require_relative 'command'

module Permpress
  # JSON Lint subcommand. Calls durable-json-lint with correct arguments.
  class JSONLint < Thor
    desc 'lint [FILES]', 'Runs linter'

    def lint(*files)
      Command.new('durable-json-lint', files, flags).run
    end

  private

    def flags
      ['--format', '{{file}}:{{line}}:{{column}}:::error:{{{description}}}']
    end
  end
end
