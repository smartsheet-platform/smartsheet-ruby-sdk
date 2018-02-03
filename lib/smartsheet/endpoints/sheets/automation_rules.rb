module Smartsheet
  # Automation Rules Endpoints
  # @see http://smartsheet-platform.github.io/api-docs/?ruby#automation-rules API Automation Rules Docs
  class AutomationRules
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end
    
    def list(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'automationrules'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
    
    def get(sheet_id:, automation_rule_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'automationrules', :automation_rule_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          automation_rule_id: automation_rule_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(sheet_id:, automation_rule_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['sheets', :sheet_id, 'automationrules', :automation_rule_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id,
          automation_rule_id: automation_rule_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, automation_rule_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'automationrules', :automation_rule_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          automation_rule_id: automation_rule_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end