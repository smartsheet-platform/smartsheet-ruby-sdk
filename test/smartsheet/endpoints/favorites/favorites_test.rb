require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class FavoritesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.favorites
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['favorites'],
            args: {body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['favorites'],
            args: {},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


