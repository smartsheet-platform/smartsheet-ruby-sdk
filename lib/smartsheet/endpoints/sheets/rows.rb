require 'smartsheet/endpoints/sheets/rows_attachments'

module Smartsheet
  class Rows
    attr_reader :client, :attachments
    private :client

    def initialize(client)
      @client = client

      @attachments = RowsAttachments.new(client)
    end

    def add(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def copy_to_another_sheet(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows', 'copy'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, row_ids:, params: {}, header_overrides: {})
      params[:ids] = row_ids
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'rows'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, row_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'rows', :row_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id,
          row_id: row_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def move_to_another_sheet(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows', 'move'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def send_via_email(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows', 'emails'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['sheets', :sheet_id, 'rows'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end