require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class SheetAttachmentTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.attachments
  end

  def self.endpoints
    [
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'attachments'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'attachments', :attachment_id],
            args: {sheet_id: 123, attachment_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :attach_url,
            method: :post,
            url: ['sheets', :sheet_id, 'attachments'],
            args: {sheet_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'attachments', :attachment_id],
            args: {sheet_id: 123, attachment_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :attach_file,
            method: :post,
            url: ['sheets', :sheet_id, 'attachments'],
            args: {sheet_id: 123, file: {}, filename: 'file', file_length: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :attach_file_from_path,
            method: :post,
            url: ['sheets', :sheet_id, 'attachments'],
            args: {sheet_id: 123, path: 'file'},
            has_params: false,
            headers: nil
        },
        {
            symbol: :attach_new_version,
            method: :post,
            url: ['sheets', :sheet_id, 'attachments', :attachment_id, 'versions'],
            args: {sheet_id: 123, attachment_id: 234, file: {}, filename: 'file', file_length: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :attach_new_version_from_path,
            method: :post,
            url: ['sheets', :sheet_id, 'attachments', :attachment_id, 'versions'],
            args: {sheet_id: 123, attachment_id: 234, path: 'file'},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete_all_versions,
            method: :delete,
            url: ['sheets', :sheet_id, 'attachments', :attachment_id, 'versions'],
            args: {sheet_id: 123, attachment_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list_versions,
            method: :get,
            url: ['sheets', :sheet_id, 'attachments', :attachment_id, 'versions'],
            args: {sheet_id: 123, attachment_id: 234},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


