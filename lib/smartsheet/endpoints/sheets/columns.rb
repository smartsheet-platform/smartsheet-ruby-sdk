module Smartsheet
  # Columns Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#columns API Columns Docs
  class Columns
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def add(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'columns'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, column_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'columns', :column_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          column_id: column_id,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, column_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'columns', :column_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          column_id: column_id,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'columns'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(sheet_id:, column_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['sheets', :sheet_id, 'columns', :column_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id,
          column_id: column_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end