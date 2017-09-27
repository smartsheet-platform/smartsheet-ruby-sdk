module Smartsheet
  class AlternateEmails
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def add(user_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['users', :user_id, 'alternateemails'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def make_primary(user_id:, alternate_email_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['users', :user_id, 'alternateemails', :alternate_email_id, 'makeprimary'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          alternate_email_id: alternate_email_id,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def delete(user_id:, alternate_email_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['users', :user_id, 'alternateemails', :alternate_email_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          alternate_email_id: alternate_email_id,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(user_id:, alternate_email_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['users', :user_id, 'alternateemails', :alternate_email_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          alternate_email_id: alternate_email_id,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(user_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['users', :user_id, 'alternateemails'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          user_id: user_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end