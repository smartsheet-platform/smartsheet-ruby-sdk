module Smartsheet
  # Webhooks Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#webhooks-reference API Webhooks Docs
  class Webhooks
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def create(body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['webhooks'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(webhook_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['webhooks', :webhook_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          webhook_id: webhook_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(webhook_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['webhooks', :webhook_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          webhook_id: webhook_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['webhooks'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def reset_shared_secret(webhook_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['webhooks', :webhook_id, 'resetsharedsecret'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          webhook_id: webhook_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(webhook_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['webhooks', :webhook_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          webhook_id: webhook_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end