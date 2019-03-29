module Smartsheet
  # Events Endpoints
  # TODO - fill in with the correct URL
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#{events_url} API Events Docs
  class Events
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end
  
    def get_events(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['events'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end