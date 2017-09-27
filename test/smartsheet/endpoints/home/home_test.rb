require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class HomeTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.home
  end

  def self.endpoints
    [
        {
            symbol: :list,
            method: :get,
            url: ['home'],
            args: {},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


