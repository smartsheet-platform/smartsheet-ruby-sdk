require 'smartsheet/api/file_spec'

module Smartsheet
  # Sheet Summaries Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#______ API Sheet Summaries Docs
  class SheetsSummaries
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def get(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'summary'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_fields(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'summary', 'fields'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_fields(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'summary', 'fields'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete_fields(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'summary', 'fields'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update_fields(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :put,
          ['sheets', :sheet_id, 'summary', 'fields'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_image(
        sheet_id:,
        field_id:,
        file:,
        filename:,
        file_length:,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'summary', 'fields', :field_id, 'images'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::ObjectFileSpec.new(file, filename, file_length, content_type),
          sheet_id: sheet_id,
          field_id: field_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_image_from_path(
        sheet_id:,
        field_id:,
        path:,
        filename: nil,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'summary', 'fields', :field_id, 'images'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::PathFileSpec.new(path, filename, content_type),
          sheet_id: sheet_id,
          field_id: field_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end