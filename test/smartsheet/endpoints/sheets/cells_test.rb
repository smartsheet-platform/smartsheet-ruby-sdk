require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class CellsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.cells
  end

  def self.endpoints
    [
        {
            symbol: :get_history,
            method: :get,
            url: ['sheets', :sheet_id, 'rows', :row_id, 'columns', :column_id, 'history'],
            args: {sheet_id: 123, row_id: 234, column_id: 345},
            has_params: true,
            headers: nil
        },

        {
            symbol: :add_image,
            method: :post,
            url: ['sheets', :sheet_id, 'rows', :row_id, 'columns', :column_id, 'cellimages'],
            args: {sheet_id: 123, row_id: 234, column_id: 345, file_options: {path: 'file'}},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


