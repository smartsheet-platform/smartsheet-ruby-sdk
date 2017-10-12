require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class TemplatesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.templates
  end

  def self.endpoints
    [
        {
            symbol: :list_public,
            method: :get,
            url: ['templates', 'public'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['templates'],
            args: {},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


