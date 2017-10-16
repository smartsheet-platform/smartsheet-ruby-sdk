require 'smartsheet/endpoints/update_requests/sent_update_requests'

module Smartsheet
  # Update Requests Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#update-requests API Update Requests
  #   Docs
  #
  # @!attribute [r] sent
  #   @return [SentUpdateRequests]
  class UpdateRequests
    attr_reader :client, :sent
    private :client

    def initialize(client)
      @client = client

      @sent = SentUpdateRequests.new(client)
    end

    def create(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'updaterequests'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, update_request_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'updaterequests', :update_request_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          update_request_id: update_request_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, update_request_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'updaterequests', :update_request_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          update_request_id: update_request_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'updaterequests'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(sheet_id:, update_request_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['sheets', :sheet_id, 'updaterequests', :update_request_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id,
          update_request_id: update_request_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end