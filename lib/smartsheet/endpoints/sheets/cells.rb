require 'smartsheet/api/file_spec'

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

    def add_image(
        sheet_id:,
        row_id:,
        column_id:,
        file:,
        filename:,
        file_length:,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'rows', :row_id, 'columns', :column_id, 'cellimages'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::ObjectFileSpec.new(file, filename, file_length, content_type),
          sheet_id: sheet_id,
          row_id: row_id,
          column_id: column_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_image_from_path(
        sheet_id:,
        row_id:,
        column_id:,
        path:,
        filename: '',
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'rows', :row_id, 'columns', :column_id, 'cellimages'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::PathFileSpec.new(path, filename, content_type),
          sheet_id: sheet_id,
          row_id: row_id,
          column_id: column_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end