require_relative '../test_helper'

module Smartsheet
  # SdkTest defines tests for the Smartsheet module.
  class SmartsheetTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Smartsheet::VERSION
    end

    def test_it_does_something_useful
      assert true
    end
  end
end

