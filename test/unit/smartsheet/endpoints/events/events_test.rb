require_relative '../endpoint_test_helper'

class ContactsTest < Minitest::Test
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
            args: {since: `2018-01-09T17:41:05Z`},
            has_params: false,
            headers: nil
        }
    ]
  end

  define_setup
  define_endpoints_tests
end


