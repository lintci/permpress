module Permpress
  class Rubocop
    # Formats Rubocop output for LintCI
    class Formatter < ::RuboCop::Formatter::BaseFormatter
      LINE_FORMAT = "%s:%d:%d:%d:%s:%s:%s\n"

      def file_finished(file, offenses)
        offenses.each do |offense|
          line = offense.line
          column = offense.real_column
          length = offense.location.length

          rule = offense.cop_name
          severity = offense.severity.name
          message = offense.message

          output.printf(LINE_FORMAT, file, line, column, length, rule, severity, message)
        end
      end
    end
  end
end
