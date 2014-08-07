require 'thor'
require_relative 'command'

module Permpress
  class GoLint < Thor
    desc 'lint [FILES]', 'Runs linter'
    method_option :config, banner: 'CONFIG_FILE'

    def lint(*files)
      Command.new('fgt golint', files, []).run
    end
  end
end
