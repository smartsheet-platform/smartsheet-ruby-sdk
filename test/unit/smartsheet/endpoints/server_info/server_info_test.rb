require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class ServerInfoTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.server_info
  end

  def self.endpoints
    [
        {
            symbol: :get,
            method: :get,
            url: ['serverinfo'],
            args: {},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


