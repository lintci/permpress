module.exports = class LintCI
  constructor: (@errorReport, options = {}) ->

  publish: ->
    for file, errors of @errorReport.paths
      for error in errors
        line = error.lineNumber
        rule = error.rule
        severity = error.level
        message = error.message

        console.log("#{file}:#{line}:::#{rule}:#{severity}:#{message}")
