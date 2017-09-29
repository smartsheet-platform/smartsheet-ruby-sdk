require 'smartsheet/endpoints/sheets/discussions_attachments'

module Smartsheet
  class Discussions
    attr_reader :client, :attachments
    private :client

    def initialize(client)
      @client = client

      @attachments = DiscussionsAttachments.new(client)
    end

    def create_on_row(sheet_id:, row_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'rows', :row_id, 'discussions'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id,
          row_id: row_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_on_sheet(sheet_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'discussions'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(sheet_id:, discussion_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'discussions', :discussion_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          discussion_id: discussion_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'discussions'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, discussion_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'discussions', :discussion_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          discussion_id: discussion_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list_row_discussions(sheet_id:, row_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'rows', :row_id, 'discussions'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id,
          row_id: row_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end