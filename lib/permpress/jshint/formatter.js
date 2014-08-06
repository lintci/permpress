"use strict";

module.exports = {
  reporter: function (results, data, opts) {
    results.forEach(function (result) {
      var file = result.file,
        error = result.error,
        line = error.line,
        column = error.character,
        rule = error.code,
        severity = rule[0] === 'E' ? 'error' : 'warning',
        message = error.reason;

      console.log(file + ':'
                + line + ':'
                + column + '::'
                + rule + ':'
                + severity + ':'
                + message);
    });
  }
};


