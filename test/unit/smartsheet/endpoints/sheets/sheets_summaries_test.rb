require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class SheetsSummariesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.summaries
  end

  def self.endpoints
    [
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'summary'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :get_fields,
            method: :get,
            url: ['sheets', :sheet_id, 'summary', 'fields'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :add_fields,
            method: :post,
            url: ['sheets', :sheet_id, 'summary', 'fields'],
            args: {sheet_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :delete_fields,
            method: :delete,
            url: ['sheets', :sheet_id, 'summary', 'fields'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :update_fields,
            method: :put,
            url: ['sheets', :sheet_id, 'summary', 'fields'],
            args: {sheet_id: 123, body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :add_image,
            method: :post,
            url: ['sheets', :sheet_id, 'summary', 'fields', :field_id, 'images'],
            args: {sheet_id: 123, field_id: 234, file: {}, filename: 'file', file_length: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :add_image_from_path,
            method: :post,
            url: ['sheets', :sheet_id, 'summary', 'fields', :field_id, 'images'],
            args: {sheet_id: 123, field_id: 234, path: 'file'},
            has_params: true,
            headers: nil
        }
    ]
  end

  define_setup
  define_endpoints_tests
end
