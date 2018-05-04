require_relative '../test_helper'
require_relative 'mock_api_test_helper.rb'

class MockApiSerializationsTest < MockApiTestHelper
  def self.tests
    [
      {
        scenario_name: 'Serialization - Attachment',
        method: ->(client, args) {client.sheets.attachments.attach_url(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'name': 'Search Engine',
            'description': 'A popular search engine',
            'attachmentType': 'LINK',
            'url': 'http://www.google.com'
          }
        }
      },
      {
        scenario_name: 'Serialization - Home',
        method: ->(client, args) {client.home.list(**args)},
        should_error: false,
        args: {}
      },
      {
        scenario_name: 'Serialization - Groups',
        method: ->(client, args) {client.groups.create(**args)},
        should_error: false,
        args: {
          body: {
            'name': 'mock api test group',
            'description': "it's a group",
            'members': [
              {
                'email': 'john.doe@smartsheet.com'
              },
              {
                'email': 'jane.doe@smartsheet.com'
              }
            ]
          }
        }
      },
      {
        scenario_name: 'Serialization - Discussion',
        method: ->(client, args) {client.sheets.discussions.create_on_row(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          row_id: 2,
          body: {
            'comment': {
              'text': 'This is a comment!'
            }
          }
        }
      },
      {
        scenario_name: 'Serialization - Contact',
        method: ->(client, args) {client.contacts.get(**args)},
        should_error: false,
        args: {
          contact_id: 'ABC'
        }
      },
      {
        scenario_name: 'Serialization - Folder',
        method: ->(client, args) {client.folders.create(**args)},
        should_error: false,
        args: {
          body: {
            'name': 'folder'
          }
        }
      },
      {
        scenario_name: 'Serialization - Column',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.sheets.columns.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'title': 'A Brave New Column',
            'type': 'PICKLIST',
            'options': [
              'option1',
              'option2',
              'option3'
            ],
            'index': 2,
            'validation': false,
            'width': 42,
            'locked': false
          }
        }
      },
      {
        scenario_name: 'Serialization - UserProfile',
        method: ->(client, args) {client.users.get_current(**args)},
        should_error: false,
        args: {
        }
      },
      {
        scenario_name: 'Serialization - Workspace',
        method: ->(client, args) {client.workspaces.create(**args)},
        should_error: false,
        args: {
          body: {
            'name': 'A Whole New Workspace'
          }
        }
      },
      {
        scenario_name: 'Serialization - User',
        method: ->(client, args) {client.users.add(**args)},
        should_error: false,
        args: {
          body: {
            'email': 'john.doe@smartsheet.com',
            'admin': false,
            'licensedSheetCreator': true,
            'firstName': 'John',
            'lastName': 'Doe',
            'groupAdmin': false,
            'resourceViewer': true
          }
        }
      },
      {
        scenario_name: 'Serialization - Sheet',
        method: ->(client, args) {client.sheets.create(**args)},
        should_error: false,
        args: {
          body: {
            'name': 'The First Sheet',
            'columns': [
              {
                'title': 'The First Column',
                'primary': true,
                'type': 'TEXT_NUMBER'
              },
              {
                'title': 'The Second Column',
                'primary': false,
                'type': 'TEXT_NUMBER',
                'systemColumnType': 'AUTO_NUMBER',
                'autoNumberFormat': {
                  'prefix': '{YYYY}-{MM}-{DD}-',
                  'suffix': '-SUFFIX',
                  'fill': '000000'
                }
              }
            ]
          }
        }
      },
      {
        scenario_name: 'Serialization - AlternateEmail',
        method: ->(client, args) {client.users.alternate_emails.add(**args)},
        should_error: false,
        args: {
          user_id: 1,
          body: [
            {
              'email': 'not.not.john.doe@smartsheet.com'
            }
          ]
        }
      },
      {
        scenario_name: 'Serialization - Predecessor',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          params: {
            include: 'objectValue'
          },
          body: {
            'cells': [
              {
                'columnId': 2,
                'objectValue': {
                  'objectType': 'PREDECESSOR_LIST',
                  'predecessors': [
                    {
                      'rowId': 3,
                      'type': 'FS',
                      'lag': {
                        'objectType': 'DURATION',
                        'negative': false,
                        'elapsed': false,
                        'weeks': 1.5,
                        'days': 2.5,
                        'hours': 3.5,
                        'minutes': 4.5,
                        'seconds': 5.5,
                        'milliseconds': 6
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      },
      {
        scenario_name: 'Serialization - IndexResult',
        method: ->(client, args) {client.users.list(**args)},
        should_error: false,
        args: {
        }
      },
      {
        scenario_name: 'Serialization - Image',
        method: ->(client, args) {client.sheets.rows.get(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          row_id: 2
        }
      },
      {
        scenario_name: 'Serialization - Image Urls',
        method: ->(client, args) {client.sheets.list_image_urls(**args)},
        should_error: false,
        args: {
          body: [
            {
              'imageId': 'abc',
              'height': 100,
              'width': 200
            }
          ]
        }
      },
      {
        scenario_name: 'Serialization - BulkFailure',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          params: {
            'allowPartialSuccess': true
          },
          body: [
            {
              'toBottom': true,
              'cells': [
                {
                  'columnId': 2,
                  'value': 'Some Value'
                }
              ]
            },
            {
              'toBottom': true,
              'cells': [
                {
                  'columnId': 3,
                  'value': 'Some Value'
                }
              ]
            }
          ]
        }
      },
      {
        scenario_name: 'Serialization - Rows',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.sheets.rows.add(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'expanded': true,
            'format': ',,,,,,,,4,,,,,,,',
            'cells': [
              {
                'columnId': 2,
                'value': 'url link',
                'strict': false,
                'hyperlink': {
                  'url': 'https://google.com'
                }
              },
              {
                'columnId': 3,
                'value': 'sheet id link',
                'strict': false,
                'hyperlink': {
                  'sheetId': 4
                }
              },
              {
                'columnId': 5,
                'value': 'report id link',
                'strict': false,
                'hyperlink': {
                  'reportId': 6
                }
              }
            ],
            'locked': false
          }
        }
      },
      {
        scenario_name: 'Serialization - Cell Link',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.sheets.rows.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'id': 2,
            'cells': [
              {
                'columnId': 3,
                'value': nil,
                'linkInFromCell': {
                  'sheetId': 4,
                  'rowId': 5,
                  'columnId': 6
                }
              }
            ]
          }
        }
      },
      {
        scenario_name: 'Serialization - Favorite',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.favorites.add(**args)},
        should_error: false,
        args: {
          body: {
            'type': 'sheet',
            'objectId': 1
          }
        }
      },
      {
        scenario_name: 'Serialization - Report',
        method: ->(client, args) {client.reports.get(**args)},
        should_error: false,
        args: {
          report_id: 1
        }
      },
      {
        scenario_name: 'Serialization - Share',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.sheets.share.create(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          params: {
            'sendEmail': true
          },
          body: {
            'email': 'john.doe@smartsheet.com',
            'accessLevel': 'VIEWER',
            'subject': 'Check out this sheet',
            'message': 'Let me know what you think. Thanks!',
            'ccMe': true
          }
        }
      },
      {
        scenario_name: 'Serialization - Send via Email',
        method: ->(client, args) {client.sheets.send_via_email(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'sendTo': [
              {
                'email': 'john.doe@smartsheet.com'
              },
              {
                'groupId': 2
              }
            ],
            'subject': 'Some subject',
            'message': 'Some message',
            'ccMe': true,
            'format': 'PDF',
            'formatDetails': {
              'paperSize': 'LETTER'
            }
          }
        }
      },
      {
        scenario_name: 'Serialization - Row Email',
        method: ->(client, args) {client.sheets.rows.send_via_email(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'sendTo': [
              {
                'groupId': 2
              }
            ],
            'subject': 'Some subject',
            'message': 'Some message',
            'columnIds': [
              3
            ],
            'includeAttachments': false,
            'includeDiscussions': true,
            'layout': 'VERTICAL',
            'rowIds': [
              4
            ]
          }
        }
      },
      {
        scenario_name: 'Serialization - Template',
        method: ->(client, args) {client.templates.list_public(**args)},
        should_error: false,
        args: {
        }
      },
      {
        scenario_name: 'Serialization - Update Request',
        method: ->(client, args) {client.update_requests.create(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'sendTo': [
              {
                'email': 'john.doe@smartsheet.com'
              }
            ],
            'rowIds': [
              2
            ],
            'columnIds': [
              3
            ],
            'includeAttachments': true,
            'includeDiscussions': false,
            'subject': 'Some subject',
            'message': 'Some message',
            'ccMe': true,
            'schedule': {
              'type': 'MONTHLY',
              'startAt': '2018-03-01T19:00:00Z',
              'endAt': '2018-06-01T00:00:00Z',
              'dayOrdinal': 'FIRST',
              'dayDescriptors': [
                'FRIDAY'
              ],
              'repeatEvery': 1
            }
          }
        }
      },
      {
        scenario_name: 'Serialization - Sent Update Requests',
        method: ->(client, args) {client.update_requests.sent.get(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          sent_update_request_id: 2
        }
      },
      {
        scenario_name: 'Serialization - Sheet Settings',
        method: ->(client, args) {client.sheets.update(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'userSettings': {
              'criticalPathEnabled': true,
              'displaySummaryTasks': true
            },
            'projectSettings': {
              'workingDays': [
                'MONDAY',
                'TUESDAY'
              ],
              'nonWorkingDays': [
                '2018-04-04',
                '2018-05-05',
                '2018-06-06'
              ],
              'lengthOfDay': 23.5
            }
          }
        }
      },
      {
        scenario_name: 'Serialization - Container Destination',
        skip: 'Awaiting updated API scenario',
        method: ->(client, args) {client.folders.copy(**args)},
        should_error: false,
        args: {
          folder_id: 1,
          body: {
            'destinationType': 'home',
            'destinationId': nil,
            'newName': 'Copy of Some Folder'
          }
        }
      },
      {
        scenario_name: 'Serialization - Cross Sheet Reference',
        method: ->(client, args) {client.sheets.cross_sheet_references.create(**args)},
        should_error: false,
        args: {
          sheet_id: 1,
          body: {
            'name': 'Some Cross Sheet Reference',
            'sourceSheetId': 2,
            'startRowId': 3,
            'endRowId': 4,
            'startColumnId': 5,
            'endColumnId': 6
          }
        }
      }
    ]
  end

  define_tests
end