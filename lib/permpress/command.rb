require 'open3'
require 'shellwords'

module Permpress
  # Generic command interface to execute a command with it's arguments, pipe the output, and exit correctly.
  class Command
    attr_reader :executable, :files, :options

    def initialize(executable, files, options = [])
      @executable = executable
      @files = files
      @options = options
    end

    def run(io = $stdout)
      Bundler.with_clean_env do
        Open3.popen3(command) do |_, stdout, _, thread|
          stdout.each do |line|
            io.puts line
          end

          exit thread.value.exitstatus
        end
      end
    end

    def command
      "#{executable} #{flags} #{arguments} 2>&1"
    end
    alias_method :to_s, :command

  private

    def flags
      Shellwords.join(options)
    end

    def arguments
      Shellwords.join(files)
    end
  end
end
