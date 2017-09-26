module Smartsheet
  class RowsAttachments
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def list(sheet_id:, row_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'rows', :row_id, 'attachments'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          row_id: row_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def attach_url(sheet_id:, row_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows', :row_id, 'attachments'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id,
          row_id: row_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def attach_file(sheet_id:, row_id:, filename:, content_type: '', header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows', :row_id, 'attachments'], body_type: :file)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          filename: filename,
          content_type: content_type,
          sheet_id: sheet_id,
          row_id: row_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end