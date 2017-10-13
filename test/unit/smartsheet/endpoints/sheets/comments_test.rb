require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class CommentsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.comments
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['sheets', :sheet_id, 'discussions', :discussion_id, 'comments'],
            args: {sheet_id: 123, discussion_id: 234, body: {}},
            has_params: false,
            headers: nil
        },
        # TODO: Add this!
        # {
        #     symbol: :add_with_file,
        #     method: :post,
        #     url: ['sheets', :sheet_id, 'rows', :row_id, 'discussions'],
        #     args: {sheet_id: 123, row_id: 234, body: {}},
        #     has_params: false,
        #     headers: nil
        # },
        {
            symbol: :update,
            method: :put,
            url: ['sheets', :sheet_id, 'comments', :comment_id],
            args: {sheet_id: 123, comment_id: 234, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'comments', :comment_id],
            args: {sheet_id: 123, comment_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'comments', :comment_id],
            args: {sheet_id: 123, comment_id: 234},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


