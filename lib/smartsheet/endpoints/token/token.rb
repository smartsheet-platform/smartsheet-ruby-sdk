require 'digest'

module Smartsheet
  # Token Endpoints
  #
  # {#get} and {#refresh} do not require an existing token to call
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#token API Token Docs
  class Token
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def build_authorization_url(client_id:, scopes:, state: nil)
      scopes_string = scopes.join('%20')
      url = "https://app.smartsheet.com/b/authorize?response_type=code&client_id=#{client_id}&scope=#{scopes_string}"
      if state.present?
        return "#{url}&state=#{state}"
      end
      return url
    end

    def get(client_id:, hash:, code:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['token'],
          no_auth: true
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params.merge({
                                   client_id: client_id,
                                   code: code,
                                   hash: hash,
                                   grant_type: 'authorization_code'
                               })
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def refresh(client_id:, hash:, refresh_token:, params: {}, header_overrides: {})
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

    def revoke(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['token'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end
