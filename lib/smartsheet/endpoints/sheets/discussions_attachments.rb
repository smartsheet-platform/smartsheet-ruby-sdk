module Smartsheet
  # Discussions Attachments Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#attachments API Attachments Docs
  class DiscussionsAttachments
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def list(sheet_id:, discussion_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'discussions', :discussion_id, 'attachments'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          discussion_id: discussion_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end