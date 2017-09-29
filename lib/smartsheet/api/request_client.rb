require 'smartsheet/api/error'

module Smartsheet
  module API
    class RequestClient
      def initialize(token, client, assume_user: nil)
        @token = token
        @client = client
        @assume_user = assume_user
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(token, endpoint_spec, request_spec, assume_user: assume_user)
        response = client.make_request(request)
        raise ApiError.new(response) unless response.success?
        response.result
      end

      private

      attr_reader :token, :client, :assume_user
    end
  end
end