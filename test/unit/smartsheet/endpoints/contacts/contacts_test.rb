require_relative '../endpoint_test_helper'

class ContactsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.contacts
  end

  def self.endpoints
    [
        {
            symbol: :get,
            method: :get,
            url: ['contacts', :contact_id],
            args: {contact_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['contacts'],
            args: {},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


