module Smartsheet
  class CommentsAttachments
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def attach_url(sheet_id:, comment_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'comments', :comment_id, 'attachments'],
          body_type: :json
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id,
          comment_id: comment_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def attach_file(sheet_id:, comment_id:, file_options:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['sheets', :sheet_id, 'comments', :comment_id, 'attachments'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_options: file_options,
          sheet_id: sheet_id,
          comment_id: comment_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end