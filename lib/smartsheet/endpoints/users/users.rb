require_relative 'alternate_emails'

module Smartsheet
  # Users Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#users API Users Docs
  #
  # @!attribute [r] alternate_emails
  #   @return [AlternateEmails]
  class Users
    attr_reader :client, :alternate_emails
    private :client

    def initialize(client)
      @client = client

      @alternate_emails = AlternateEmails.new(client)
    end

    def add(body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['users'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_current(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['users', 'me'])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(user_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['users', :user_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['users'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def remove(user_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['users', :user_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def update(user_id:, body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['users', :user_id], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          params: params,
          header_overrides: header_overrides,
          body: body,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_profile_image(
        user_id:,
        file:,
        filename:,
        file_length:,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['users', :user_id, 'profileimage'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::ObjectFileSpec.new(file, filename, file_length, content_type),
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def add_profile_image_from_path(
        user_id:,
        path:,
        filename: nil,
        content_type: '',
        params: {},
        header_overrides: {}
    )
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :post,
          ['users', :user_id, 'profileimage'],
          body_type: :file
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          file_spec: Smartsheet::API::PathFileSpec.new(path, filename, content_type),
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

  end
end