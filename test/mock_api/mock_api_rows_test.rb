require_relative '../test_helper'
require_relative 'mock_api_test_helper.rb'

class MockApiRowsTest < MockApiTestHelper
  def self.tests
    [
      {
        scenario_name: 'Add Rows - Assign Values - String',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Apple'
                },
                {
                  'columnId': 102,
                  'value': 'Red Fruit'
                }
              ]
            },
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Banana'
                },
                {
                  'columnId': 102,
                  'value': 'Yellow Fruit'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Values - Int',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 100
                },
                {
                  'columnId': 102,
                  'value': 'One Hundred'
                }
              ]
            },
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 2.1
                },
                {
                  'columnId': 102,
                  'value': 'Two Point One'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Values - Bool',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': true
                },
                {
                  'columnId': 102,
                  'value': 'This is True'
                }
              ]
            },
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': false
                },
                {
                  'columnId': 102,
                  'value': 'This is False'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Formulae',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'formula': '=SUM([Column2]3, [Column2]4)*2'
                },
                {
                  'columnId': 102,
                  'formula': '=SUM([Column2]3, [Column2]3, [Column2]4)'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Values - Hyperlink',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Google',
                  'hyperlink': {
                    'url': 'http://google.com'
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Bing',
                  'hyperlink': {
                    'url': 'http://bing.com'
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Values - Hyperlink SheetID',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Sheet2',
                  'hyperlink': {
                    'sheetId': 2
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Sheet3',
                  'hyperlink': {
                    'sheetId': 3
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Values - Hyperlink ReportID',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Report9',
                  'hyperlink': {
                    'reportId': 9
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Report8',
                  'hyperlink': {
                    'reportId': 8
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Invalid - Assign Value and Formulae',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: true,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'formula': '=SUM([Column2]3, [Column2]4)*2',
                  'value': '20'
                },
                {
                  'columnId': 102,
                  'formula': '=SUM([Column2]3, [Column2]3, [Column2]4)'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Invalid - Assign Hyperlink URL and SheetId',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: true,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Google',
                  'hyperlink': {
                    'url': 'http://google.com',
                    'sheetId': 2
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Bing',
                  'hyperlink': {
                    'url': 'http://bing.com'
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Location - Top',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'toTop': true,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Apple'
                },
                {
                  'columnId': 102,
                  'value': 'Red Fruit'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Location - Bottom',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'toBottom': true,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Apple'
                },
                {
                  'columnId': 102,
                  'value': 'Red Fruit'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Values - String',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Apple'
                },
                {
                  'columnId': 102,
                  'value': 'Red Fruit'
                }
              ]
            },
            {
              'id': 11,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Banana'
                },
                {
                  'columnId': 102,
                  'value': 'Yellow Fruit'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Values - Int',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': 100
                },
                {
                  'columnId': 102,
                  'value': 'One Hundred'
                }
              ]
            },
            {
              'id': 11,
              'cells': [
                {
                  'columnId': 101,
                  'value': 2.1
                },
                {
                  'columnId': 102,
                  'value': 'Two Point One'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Values - Bool',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': true
                },
                {
                  'columnId': 102,
                  'value': 'This is True'
                }
              ]
            },
            {
              'id': 11,
              'cells': [
                {
                  'columnId': 101,
                  'value': false
                },
                {
                  'columnId': 102,
                  'value': 'This is False'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Formulae',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 11,
              'cells': [
                {
                  'columnId': 101,
                  'formula': '=SUM([Column2]3, [Column2]4)*2'
                },
                {
                  'columnId': 102,
                  'formula': '=SUM([Column2]3, [Column2]3, [Column2]4)'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Values - Hyperlink',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Google',
                  'hyperlink': {
                    'url': 'http://google.com'
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Bing',
                  'hyperlink': {
                    'url': 'http://bing.com'
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Values - Hyperlink SheetID',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Sheet2',
                  'hyperlink': {
                    'sheetId': 2
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Sheet3',
                  'hyperlink': {
                    'sheetId': 3
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Assign Values - Hyperlink ReportID',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Report9',
                  'hyperlink': {
                    'reportId': 9
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Report8',
                  'hyperlink': {
                    'reportId': 8
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Invalid - Assign Value and Formulae',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: true,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'formula': '=SUM([Column2]3, [Column2]4)*2',
                  'value': '20'
                },
                {
                  'columnId': 102,
                  'formula': '=SUM([Column2]3, [Column2]3, [Column2]4)'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Invalid - Assign Hyperlink URL and SheetId',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: true,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': 'Google',
                  'hyperlink': {
                    'url': 'http://google.com',
                    'sheetId': 2
                  }
                },
                {
                  'columnId': 102,
                  'value': 'Bing',
                  'hyperlink': {
                    'url': 'http://bing.com'
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Add Rows - Assign Object Value - Predecessor List',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'cells': [
                {
                  'columnId': 101,
                  'objectValue': {
                    'objectType': 'PREDECESSOR_LIST',
                    'predecessors': [
                      {
                        'rowId': 10,
                        'type': 'FS',
                        'lag': {
                          'objectType': 'DURATION',
                          'days': 2,
                          'hours': 4
                        }
                      }
                    ]
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Clear Value - Text Number',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': ''
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Clear Value - Checkbox',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': ''
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Clear Value - Hyperlink',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': '',
                  'hyperlink': nil
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Clear Value - Cell Link',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': '',
                  'linkInFromCell': nil
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Invalid - Assign Hyperlink and Cell Link',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: true,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'cells': [
                {
                  'columnId': 101,
                  'value': '',
                  'linkInFromCell': {
                    'sheetId': 2,
                    'rowId': 20,
                    'columnId': 201
                  },
                  'hyperlink': {
                    'url': 'www.google.com'
                  }
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Location - Top',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'toTop': true
            }
          ]
        }
      },
      {
        scenario_name: 'Update Rows - Location - Bottom',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: [
            {
              'id': 10,
              'toBottom': true
            }
          ]
        }
      }
    ]
  end
  

  define_tests
end
