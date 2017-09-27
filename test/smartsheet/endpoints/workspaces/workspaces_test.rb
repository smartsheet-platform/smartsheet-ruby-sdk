require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class WorkspacesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.workspaces
  end

  def self.endpoints
    [
        {
            symbol: :copy,
            method: :post,
            url: ['workspaces', :workspace_id, 'copy'],
            args: {workspace_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :create,
            method: :post,
            url: ['workspaces'],
            args: {body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['workspaces', :workspace_id],
            args: {workspace_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['workspaces', :workspace_id],
            args: {workspace_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['workspaces'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['workspaces', :workspace_id],
            args: {workspace_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


