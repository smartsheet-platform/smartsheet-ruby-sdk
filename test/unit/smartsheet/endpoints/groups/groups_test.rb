require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class GroupsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.groups
  end

  def self.endpoints
    [
        {
            symbol: :create,
            method: :post,
            url: ['groups'],
            args: {body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['groups', :group_id],
            args: {group_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['groups', :group_id],
            args: {group_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :list,
            method: :get,
            url: ['groups'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['groups', :group_id],
            args: {group_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :add_members,
            method: :post,
            url: ['groups', :group_id, 'members'],
            args: {group_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :remove_member,
            method: :delete,
            url: ['groups', :group_id, 'members', :user_id],
            args: {group_id: 123, user_id: 234},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


