require_relative '../test_helper'
require_relative 'mock_api_test_helper.rb'

class MockApiSheetsTest < MockApiTestHelper
  def self.tests
    [
      {
        scenario_name: 'List Sheets - No Params',
        method: ->(client, args) {client.sheets.list(**args)},
        should_error: false,
        args: {
        }
      },
      {
        scenario_name: 'List Sheets - Include Owner Info',
        method: ->(client, args) {client.sheets.list(**args)},
        should_error: false,
        args: {
          params: {
            'include': 'ownerInfo'
          }
        }
      },
      {
        scenario_name: 'Create Sheet - Invalid - No Columns',
        method: ->(client, args) {client.sheets.create(**args)},
        should_error: true,
        args: {
          body: {
            'name': 'New Sheet',
            'columns': [
    
            ]
          }
        }
      }
    ]
  end

  define_tests
end
