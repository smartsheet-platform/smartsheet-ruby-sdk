module Smartsheet
  class Groups
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def create(body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['groups'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(group_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['groups', :group_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          group_id: group_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(group_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['groups', :group_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          group_id: group_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['groups'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(group_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['groups', :group_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          group_id: group_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_members(group_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['groups', :group_id, 'members'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          group_id: group_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def remove_member(group_id:, user_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['groups', :group_id, 'members', :user_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          group_id: group_id,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end