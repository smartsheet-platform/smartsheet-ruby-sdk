require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class AlternateEmailsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.users.alternate_emails
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['users', :user_id, 'alternateemails'],
            args: {user_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :make_primary,
            method: :post,
            url: ['users', :user_id, 'alternateemails', :alternate_email_id, 'makeprimary'],
            args: {user_id: 123, alternate_email_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['users', :user_id, 'alternateemails', :alternate_email_id],
            args: {user_id: 123, alternate_email_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['users', :user_id, 'alternateemails', :alternate_email_id],
            args: {user_id: 123, alternate_email_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['users', :user_id, 'alternateemails'],
            args: {user_id: 123},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


