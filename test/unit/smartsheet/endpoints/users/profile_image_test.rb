require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class ProfileImageTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.users.profile_image
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['users', :user_id, 'profileimage'],
            args: {user_id: 123, file: {}, filename: 'file', file_length: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :add_from_path,
            method: :post,
            url: ['users', :user_id, 'profileimage'],
            args: {user_id: 123, path: 'file'},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


