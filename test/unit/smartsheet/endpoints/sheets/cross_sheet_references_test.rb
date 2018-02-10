require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class CrossSheetReferencesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.cross_sheet_references
  end

  def self.endpoints
    [
        {
            symbol: :create,
            method: :post,
            url: ['sheets', :sheet_id, 'crosssheetreferences'],
            args: {sheet_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'crosssheetreferences'],
            args: {sheet_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'crosssheetreferences', :cross_sheet_reference_id],
            args: {sheet_id: 123, cross_sheet_reference_id: 234},
            has_params: false,
            headers: nil
        }
    ]
  end

  define_setup
  define_endpoints_tests
end


