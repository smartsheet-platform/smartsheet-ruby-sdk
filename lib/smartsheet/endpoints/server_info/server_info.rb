module Smartsheet
  class ServerInfo
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    # TODO: Should be able to run this unauthenticated
    def get(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['serverinfo'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end