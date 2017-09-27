require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class SightsShareTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sights.share
  end

  def self.endpoints
    [
        {
            symbol: :delete,
            method: :delete,
            url: ['sights', :sight_id, 'shares', :share_id],
            args: {sight_id: 123, share_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sights', :sight_id, 'shares', :share_id],
            args: {sight_id: 123, share_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['sights', :sight_id, 'shares'],
            args: {sight_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :create,
            method: :post,
            url: ['sights', :sight_id, 'shares'],
            args: {sight_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['sights', :sight_id, 'shares', :share_id],
            args: {sight_id: 123, share_id: 234, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


