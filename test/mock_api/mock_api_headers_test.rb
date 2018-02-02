require_relative '../test_helper'
require_relative 'mock_api_test_helper.rb'

class MockApiHeaderTest < MockApiTestHelper
  def self.tests
    [
      {
        scenario_name: 'Change Agent Header - Can Be Passed',
        method: ->(client, args) {client.sheets.create(**args)},
        should_error: false,
        args: {
          body: {
            'name': 'My new sheet',
            'columns': [
              {
                'title': 'Col1',
                'primary': true,
                'type': 'TEXT_NUMBER'
              }
            ]
          },
          header_overrides: {
            'Smartsheet-Change-Agent': 'MyChangeAgent'
          }
        }
      }
    ]
  end

  define_tests
end
