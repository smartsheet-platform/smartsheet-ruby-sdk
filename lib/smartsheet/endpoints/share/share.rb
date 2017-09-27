module Smartsheet
  module Share
    def delete_share(share_id:, url:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, url + ['shares', :share_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          share_id: share_id,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_share(share_id:, url:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, url + ['shares', :share_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          share_id: share_id,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list_share(url:, params:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, url + ['shares'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_share(url:, body:, params:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, url + ['shares'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update_share(share_id:, url:, body:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, url + ['shares', :share_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          share_id: share_id,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end