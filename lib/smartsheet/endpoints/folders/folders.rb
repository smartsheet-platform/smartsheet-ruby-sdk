module Smartsheet
  class Folders
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def copy(folder_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['folders', :folder_id, 'copy'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          body: body,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create(body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['home', 'folders'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_in_folder(folder_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['folders', :folder_id, 'folders'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def create_in_workspace(workspace_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['workspaces', :workspace_id, 'folders'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          workspace_id: workspace_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(folder_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['folders', :folder_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(folder_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['folders', :folder_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['home', 'folders'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list_in_folder(folder_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['folders', :folder_id, 'folders'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list_in_workspace(workspace_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['workspaces', :workspace_id, 'folders'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          workspace_id: workspace_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def move(folder_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['folders', :folder_id, 'move'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(folder_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['folders', :folder_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          folder_id: folder_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end