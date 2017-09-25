module Smartsheet
  class Comments
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def add(sheet_id:, discussion_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'discussions', :discussion_id, 'comments'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id,
          discussion_id: discussion_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(sheet_id:, comment_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['sheets', :sheet_id, 'comments', :comment_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id,
          comment_id: comment_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, comment_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'comments', :comment_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          comment_id: comment_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, comment_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'comments', :comment_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          comment_id: comment_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end