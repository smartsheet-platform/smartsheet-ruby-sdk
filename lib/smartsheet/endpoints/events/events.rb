module Smartsheet
  # Events Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#event-reporting API Events Docs
  class Events
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end
  
    def get(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['events'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end