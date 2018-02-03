require_relative '../../../../test_helper'
require_relative '../endpoint_test_helper'

class AutomationRulesTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.sheets.automation_rules
  end

  def self.endpoints
    [
        {
            symbol: :list,
            method: :get,
            url: ['sheets', :sheet_id, 'automationrules'],
            args: {sheet_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :get,
            method: :get,
            url: ['sheets', :sheet_id, 'automationrules', :automation_rule_id],
            args: {sheet_id: 123, automation_rule_id: 234},
            has_params: false,
            headers: nil
        },
        {
            symbol: :update,
            method: :put,
            url: ['sheets', :sheet_id, 'automationrules', :automation_rule_id],
            args: {sheet_id: 123, automation_rule_id: 234, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :delete,
            method: :delete,
            url: ['sheets', :sheet_id, 'automationrules', :automation_rule_id],
            args: {sheet_id: 123, automation_rule_id: 234},
            has_params: false,
            headers: nil
        }
    ]
  end

  define_setup
  define_endpoints_tests
end


