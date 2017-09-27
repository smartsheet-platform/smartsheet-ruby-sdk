module Smartsheet
  class Cells
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def get_history(sheet_id:, row_id:, column_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :get,
          ['sheets', :sheet_id, 'rows', :row_id, 'columns', :column_id, 'history']
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id,
          row_id: row_id,
          column_id: column_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_image(sheet_id:, row_id:, column_id:, filename:, content_type: '', params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'rows', :row_id, 'columns', :column_id, 'cellimages'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          filename: filename,
          content_type: content_type,
          sheet_id: sheet_id,
          row_id: row_id,
          column_id: column_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end