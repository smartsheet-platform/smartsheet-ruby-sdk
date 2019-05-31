require_relative '../endpoint_test_helper'

class EventsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.events
  end

  def self.endpoints
    [
      {
        symbol: :get,
        method: :get,
        url: ['events'],
        args: {},
        has_params: true,
        headers: nil
      }
    ]
  end

  define_setup
  define_endpoints_tests
end


