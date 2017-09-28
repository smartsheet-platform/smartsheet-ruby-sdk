require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class TokenTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.token
  end

  def self.endpoints
    [
        {
            symbol: :get,
            method: :post,
            url: ['token'],
            args: {client_id: '123', code: '234', app_secret: '345'},
            has_params: true,
            expected_params: {
                grant_type: 'authorization_code',
                client_id: '123',
                code: '234',
                hash: '2f7719345f3282ca527239d680b738693e7c5cd678423fef756f4443785d2bee'
            },
            headers: nil
        },
        {
            symbol: :refresh,
            method: :post,
            url: ['token'],
            args: {client_id: '123', refresh_token: '234', app_secret: '345'},
            has_params: true,
            expected_params: {
                grant_type: 'refresh_token',
                client_id: '123',
                refresh_token: '234',
                hash: '2f7719345f3282ca527239d680b738693e7c5cd678423fef756f4443785d2bee'
            },
            headers: nil
        },
        {
            symbol: :revoke,
            method: :delete,
            url: ['token'],
            args: {},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


