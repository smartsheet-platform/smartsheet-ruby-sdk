require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class SightsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sights
  end

  def self.endpoints
    [
        {
            symbol: :copy,
            method: :post,
            url: ['sights', :sight_id, 'copy'],
            args: {sight_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sights', :sight_id],
            args: {sight_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sights', :sight_id],
            args: {sight_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['sights'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :move,
            method: :post,
            url: ['sights', :sight_id, 'move'],
            args: {sight_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get_publish_status,
            method: :get,
            url: ['sights', :sight_id, 'publish'],
            args: {sight_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :set_publish_status,
            method: :put,
            url: ['sights', :sight_id, 'publish'],
            args: {sight_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['sights', :sight_id],
            args: {sight_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


