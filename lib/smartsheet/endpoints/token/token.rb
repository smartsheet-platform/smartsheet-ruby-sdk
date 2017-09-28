module Smartsheet
  class Token
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def get(client_id:, code:, hash:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['token'],
          no_auth: true
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params.merge({client_id: client_id, code: code, hash: hash, grant_type: 'authorization_code'})
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def refresh(client_id:, refresh_token:, hash:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['token'],
          no_auth: true
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params.merge({
                                   client_id: client_id,
                                   refresh_token: refresh_token,
                                   hash: hash,
                                   grant_type: 'refresh_token'
                               })
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def revoke(header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['token'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end