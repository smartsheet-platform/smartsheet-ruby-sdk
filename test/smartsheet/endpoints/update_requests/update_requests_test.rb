require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class UpdateRequestsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.update_requests
  end

  def self.endpoints
    [
        {
            symbol: :create,
            method: :post,
            url: ['sheets', :sheet_id, 'updaterequests'],
            args: {sheet_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'updaterequests', :update_request_id],
            args: {sheet_id: 123, update_request_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'updaterequests', :update_request_id],
            args: {sheet_id: 123, update_request_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'updaterequests'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['sheets', :sheet_id, 'updaterequests', :update_request_id],
            args: {sheet_id: 123, update_request_id: 234, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


