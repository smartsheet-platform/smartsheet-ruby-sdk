require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class RowsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.rows
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['sheets', :sheet_id, 'rows'],
            args: {sheet_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :copy_to_another_sheet,
            method: :post,
            url: ['sheets', :sheet_id, 'rows', 'copy'],
            args: {sheet_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'rows'],
            args: {sheet_id: 123, row_ids: [234, 345]},
            has_params: true,
            expected_params: {ids: '234,345'},
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'rows', :row_id],
            args: {sheet_id: 123, row_id: 234},
            has_params: true,
            headers: nil
        },
        {
            symbol: :move_to_another_sheet,
            method: :post,
            url: ['sheets', :sheet_id, 'rows', 'move'],
            args: {sheet_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :send_via_email,
            method: :post,
            url: ['sheets', :sheet_id, 'rows', 'emails'],
            args: {sheet_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['sheets', :sheet_id, 'rows'],
            args: {sheet_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


