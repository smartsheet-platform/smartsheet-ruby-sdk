require 'faraday'
require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class SheetTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

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
            has_params: true
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
            has_params: true
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
            headers: {Accept: 'application/vnd.ms-excel'}
        },
        {
            symbol: :get_as_pdf,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
            has_params: true,
            headers: {Accept: 'application/pdf'}
        },
        {
            symbol: :get_as_csv,
            method: :get,
            url: ['sheets', :sheet_id],
            args: {sheet_id: 123},
            headers: {Accept: 'text/csv'}
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
            has_params: true
        },
        {
            symbol: :create_from_template,
            method: :post,
            url: ['sheets'],
            args: {body: {}},
            has_params: true
        },
        {
            symbol: :create_in_folder_from_template,
            method: :post,
            url: ['folders', :folder_id, 'sheets'],
            args: {folder_id: 123, body: {}},
            has_params: true
        },
        {
            symbol: :copy,
            method: :post,
            url: ['sheets', :sheet_id, 'copy'],
            args: {sheet_id: 123, body: {}},
            has_params: true
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
        }
    ]
  end

  define_setup
  define_endpoints_tests
end
