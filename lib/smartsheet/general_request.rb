require 'smartsheet/api/file_spec'

module Smartsheet
  module GeneralRequest
    def request(method:, url_path:, body: nil, params: {}, header_overrides: {})
      spec = body.nil? ? {} : {body_type: :json}
      endpoint_spec = Smartsheet::API::EndpointSpec.new(method, [url_path], **spec)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def request_with_file(
        method:,
        url_path:,
        file:,
        file_length:,
        filename:,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(method, [url_path], body_type: :file)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::ObjectFileSpec.new(file, filename, file_length, content_type)
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def request_with_file_from_path(
        method:,
        url_path:,
        path:,
        filename: nil,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(method, [url_path], body_type: :file)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::PathFileSpec.new(path, filename, content_type)
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end