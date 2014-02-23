#encoding: utf-8

require_relative "test"
require_relative "../lib/epimath100/error.class"

def test_error
  log = []

  test_put_header "Error"

  log << "1. Test of the default value of the errors..."

  log << Error.default = Error::ERR_LOW
  log << "\t= Warning"

  log << Error.default
  log << "\t= Warning"

  log << Error.default = "prout"
  log << "\t= Warning"

  log << Error.default
  log << "\t= Fatal Error"

  log << Error.default = Error::ERR_MEDIUM
  log << "\t= Error"

  test_put_footer "Error"

  return log
end
