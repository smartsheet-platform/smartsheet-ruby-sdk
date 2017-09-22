require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class SearchTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.search
  end

  def self.endpoints
    [
        {
            symbol: :search_all,
            method: :get,
            url: ['search'],
            args: {query: 'query'},
            has_params: false,
            headers: nil
        },
        {
            symbol: :search_sheet,
            method: :get,
            url: ['search', 'sheets', :sheet_id],
            args: {query: 'query', sheet_id: 123},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


