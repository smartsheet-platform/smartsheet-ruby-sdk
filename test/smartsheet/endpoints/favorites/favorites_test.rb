require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class FavoritesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.favorites
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['favorites'],
            args: {body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['favorites'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :remove_folder,
            method: :delete,
            url: ['favorites', 'folder', :folder_id],
            args: {folder_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_report,
            method: :delete,
            url: ['favorites', 'report', :report_id],
            args: {report_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_sheet,
            method: :delete,
            url: ['favorites', 'sheet', :sheet_id],
            args: {sheet_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_sight,
            method: :delete,
            url: ['favorites', 'sights', :sight_id],
            args: {sight_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_template,
            method: :delete,
            url: ['favorites', 'template', :template_id],
            args: {template_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_workspace,
            method: :delete,
            url: ['favorites', 'workspace', :workspace_id],
            args: {workspace_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_folders,
            method: :delete,
            url: ['favorites', 'folder'],
            args: {folder_ids: [123, 234, 345]},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_reports,
            method: :delete,
            url: ['favorites', 'report'],
            args: {report_ids: [123, 234, 345]},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_sheets,
            method: :delete,
            url: ['favorites', 'sheet'],
            args: {sheet_ids: [123, 234, 345]},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_sights,
            method: :delete,
            url: ['favorites', 'sights'],
            args: {sight_ids: [123, 234, 345]},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_templates,
            method: :delete,
            url: ['favorites', 'template'],
            args: {template_ids: [123, 234, 345]},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_workspaces,
            method: :delete,
            url: ['favorites', 'workspace'],
            args: {workspace_ids: [123, 234, 345]},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


