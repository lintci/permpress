require 'thor'
require_relative 'command'

module Permpress
  # Rubocop subcommand. Calls Rubocop with correct arguments.
  class CppCheck < Thor

    desc 'lint [FILES]', 'Runs linter'

    def lint(*files)
      Command.new('cppcheck', files, flags).run
    end

  private

    def flags
      [
        '--enable=all',
        '--error-exitcode=1',
        '--template="{file}:{line}:::{id}:{severity}:{message}"'
      ]
    end
  end
end
