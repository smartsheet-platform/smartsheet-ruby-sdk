require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class DiscussionsAttachmentsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.discussions.attachments
  end

  def self.endpoints
    [
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'discussions', :discussion_id, 'attachments'],
            args: {sheet_id: 123, discussion_id: 234},
            has_params: true,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


