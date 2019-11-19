require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class UsersTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.users
  end

  def self.endpoints
    [
        {
            symbol: :add,
            method: :post,
            url: ['users'],
            args: {body: {}},
            has_params: true,
            headers: nil
        },
        {
            symbol: :get_current,
            method: :get,
            url: ['users', 'me'],
            args: {},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['users', :user_id],
            args: {user_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['users'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :remove,
            method: :delete,
            url: ['users', :user_id],
            args: {user_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['users', :user_id],
            args: {user_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :add_profile_image,
            method: :post,
            url: ['users', :user_id, 'profileimage'],
            args: {user_id: 123, file: {}, filename: 'file', file_length: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :add_profile_image_from_path,
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


