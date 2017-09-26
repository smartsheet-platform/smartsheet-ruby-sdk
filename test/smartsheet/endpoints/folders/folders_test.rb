require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class FoldersTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.folders
  end

  def self.endpoints
    [
        {
            symbol: :copy,
            method: :post,
            url: ['folders', :folder_id, 'copy'],
            args: {folder_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :create,
            method: :post,
            url: ['home', 'folders'],
            args: {body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :create_in_folder,
            method: :post,
            url: ['folders', :folder_id, 'folders'],
            args: {folder_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :create_in_workspace,
            method: :post,
            url: ['workspaces', :workspace_id, 'folders'],
            args: {workspace_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['folders', :folder_id],
            args: {folder_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['folders', :folder_id],
            args: {folder_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['home', 'folders'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :list_in_folder,
            method: :get,
            url: ['folders', :folder_id, 'folders'],
            args: {folder_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :list_in_workspace,
            method: :get,
            url: ['workspaces', :workspace_id, 'folders'],
            args: {workspace_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :move,
            method: :post,
            url: ['folders', :folder_id, 'move'],
            args: {folder_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['folders', :folder_id],
            args: {folder_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


