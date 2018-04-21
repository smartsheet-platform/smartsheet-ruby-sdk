require 'smartsheet/constants'

require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class SheetTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper
  include Smartsheet::Constants

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets
  end

  def self.endpoints
    [
        {
            symbol: :list,
            method: :get,
            url: ['sheets'],
            args: {},
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
        },
        {
            symbol: :get_version,
            method: :get,
            url: ['sheets', :sheet_id, 'version'],
            args: {sheet_id: 123}
        },
        {
            symbol: :get_as_excel,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
            headers: {Accept: EXCEL_TYPE}
        },
        {
            symbol: :get_as_pdf,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
            headers: {Accept: PDF_TYPE}
        },
        {
            symbol: :get_as_csv,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
            headers: {Accept: CSV_TYPE}
        },
        {
            symbol: :create,
            method: :post,
            url: ['sheets'],
            args: {body: {}}
        },
        {
            symbol: :create_in_folder,
            method: :post,
            url: ['folders', :folder_id, 'sheets'],
            args: {folder_id: 123, body: {}}
        },
        {
            symbol: :create_in_workspace,
            method: :post,
            url: ['workspaces', :workspace_id, 'sheets'],
            args: {workspace_id: 123, body: {}}
        },
        {
            symbol: :create_in_workspace_from_template,
            method: :post,
            url: ['workspaces', :workspace_id, 'sheets'],
            args: {workspace_id: 123, body: {}},
        },
        {
            symbol: :create_from_template,
            method: :post,
            url: ['sheets'],
            args: {body: {}},
        },
        {
            symbol: :create_in_folder_from_template,
            method: :post,
            url: ['folders', :folder_id, 'sheets'],
            args: {folder_id: 123, body: {}},
        },
        {
            symbol: :import_from_file,
            method: :post,
            url: ['sheets', 'import'],
            args: {file: {}, file_type: :csv, file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file,
            method: :post,
            url: ['sheets', 'import'],
            args: {file: {}, file_type: :xlsx, file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_path,
            method: :post,
            url: ['sheets', 'import'],
            args: {path: 'file', file_type: :csv},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_path,
            method: :post,
            url: ['sheets', 'import'],
            args: {path: 'file', file_type: :xlsx},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_into_folder,
            method: :post,
            url: ['folders', :folder_id, 'sheets', 'import'],
            args: {folder_id: 123, file: {}, file_type: :csv, file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_into_folder,
            method: :post,
            url: ['folders', :folder_id, 'sheets', 'import'],
            args: {folder_id: 123, file: {}, file_type: :xlsx, file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_path_into_folder,
            method: :post,
            url: ['folders', :folder_id, 'sheets', 'import'],
            args: {folder_id: 123, path: 'file', file_type: :csv},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_path_into_folder,
            method: :post,
            url: ['folders', :folder_id, 'sheets', 'import'],
            args: {folder_id: 123, path: 'file', file_type: :xlsx},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_into_workspace,
            method: :post,
            url: ['workspaces', :workspace_id, 'sheets', 'import'],
            args: {workspace_id: 123, file: {}, file_type: :csv, file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_into_workspace,
            method: :post,
            url: ['workspaces', :workspace_id, 'sheets', 'import'],
            args: {workspace_id: 123, file: {}, file_type: :xlsx, file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_path_into_workspace,
            method: :post,
            url: ['workspaces', :workspace_id, 'sheets', 'import'],
            args: {workspace_id: 123, path: 'file', file_type: :csv},
            has_params: true,
            headers: nil
        },
        {
            symbol: :import_from_file_path_into_workspace,
            method: :post,
            url: ['workspaces', :workspace_id, 'sheets', 'import'],
            args: {workspace_id: 123, path: 'file', file_type: :xlsx},
            has_params: true,
            headers: nil
        },
        {
            symbol: :copy,
            method: :post,
            url: ['sheets', :sheet_id, 'copy'],
            args: {sheet_id: 123, body: {}},
        },
        {
            symbol: :move,
            method: :post,
            url: ['sheets', :sheet_id, 'move'],
            args: {sheet_id: 123, body: {}},
        },
        {
            symbol: :update,
            method: :put,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123, body: {}}
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123}
        },
        {
            symbol: :list_for_org,
            method: :get,
            url: ['users', 'sheets'],
            args: {},
        },
        {
            symbol: :get_publish_status,
            method: :get,
            url: ['sheets', :sheet_id, 'publish'],
            args: {sheet_id: 123},
        },
        {
            symbol: :set_publish_status,
            method: :put,
            url: ['sheets', :sheet_id, 'publish'],
            args: {sheet_id: 123, body: {}},
        },
        {
            symbol: :send_via_email,
            method: :post,
            url: ['sheets', :sheet_id, 'emails'],
            args: {sheet_id: 123, body: {}},
        },
        {
            symbol: :list_image_urls,
            method: :post,
            url: ['imageurls'],
            args: {body: {}},
        },
    ]
  end

  define_setup
  define_endpoints_tests
end
