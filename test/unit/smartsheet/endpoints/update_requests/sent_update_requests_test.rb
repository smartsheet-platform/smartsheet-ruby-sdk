require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class SentUpdateRequestsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.update_requests.sent
  end

  def self.endpoints
    [
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'sentupdaterequests', :sent_update_request_id],
            args: {sheet_id: 123, sent_update_request_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'sentupdaterequests', :sent_update_request_id],
            args: {sheet_id: 123, sent_update_request_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'sentupdaterequests'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


