module Smartsheet
  # Home Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#home API Home Docs
  class Home
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['home'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end