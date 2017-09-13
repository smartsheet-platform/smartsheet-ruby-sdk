require_relative '../../test_helper'

module Smartsheet
  module Ruby
    # SdkTest defines tests for the Smartsheet::Ruby::Sdk module.
    class SdkTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil ::Smartsheet::Ruby::Sdk::VERSION
      end

      def test_it_does_something_useful
        assert true
      end
    end
  end
end

