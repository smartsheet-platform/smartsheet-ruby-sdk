require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class WebhooksTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.webhooks
  end

  def self.endpoints
    [
        {
            symbol: :create,
            method: :post,
            url: ['webhooks'],
            args: {body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['webhooks', :webhook_id],
            args: {webhook_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['webhooks', :webhook_id],
            args: {webhook_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['webhooks'],
            args: {},
            has_params: false,
            headers: nil
        },
        {
            symbol: :reset_shared_secret,
            method: :post,
            url: ['webhooks', :webhook_id, 'resetsharedsecret'],
            args: {webhook_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['webhooks', :webhook_id],
            args: {webhook_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


