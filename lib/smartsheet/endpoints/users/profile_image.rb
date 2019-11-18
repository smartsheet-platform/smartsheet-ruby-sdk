module Smartsheet
  # Profile Image Endpoint
  # @see http://smartsheet-platform.github.io/api-docs/?ruby#update-user-profile-image API
  #   Update User Profile Image
  class ProfileImage
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def add(
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

    def add_from_path(
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