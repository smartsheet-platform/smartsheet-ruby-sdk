require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class DiscussionsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.discussions
  end

  def self.endpoints
    [
        {
            symbol: :create_on_row,
            method: :post,
            url: ['sheets', :sheet_id, 'rows', :row_id, 'discussions'],
            args: {sheet_id: 123, row_id: 234, body: {}},
            has_params: false,
            headers: nil
        },
        # TODO: Write this!
        # {
        #     symbol: :create_on_row_with_attachment,
        #     method: :post,
        #     url: ['sheets', :sheet_id, 'rows', :row_id, 'discussions'],
        #     args: {sheet_id: 123, row_id: 234, body: {}},
        #     has_params: false,
        #     headers: nil
        # },
        {
            symbol: :create_on_sheet,
            method: :post,
            url: ['sheets', :sheet_id, 'discussions'],
            args: {sheet_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        # TODO: Write this!
        # {
        #     symbol: :create_on_sheet_with_attachment,
        #     method: :post,
        #     url: ['sheets', :sheet_id, 'discussions'],
        #     args: {sheet_id: 123, body: {}},
        #     has_params: false,
        #     headers: nil
        # },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'discussions', :discussion_id],
            args: {sheet_id: 123, discussion_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'discussions'],
            args: {sheet_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'discussions', :discussion_id],
            args: {sheet_id: 123, discussion_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list_row_discussions,
            method: :get,
            url: ['sheets', :sheet_id, 'rows', :row_id, 'discussions'],
            args: {sheet_id: 123, row_id: 234},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


