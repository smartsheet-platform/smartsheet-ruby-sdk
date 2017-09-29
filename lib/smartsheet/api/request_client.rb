require 'smartsheet/api/error'

module Smartsheet
  module API
    class RequestClient
      def initialize(token, client)
        @token = token
        @client = client
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(token, endpoint_spec, request_spec)
        response = client.make_request(request)
        raise ApiError.new(response) unless response.success?
        response.result
      end

      private

      attr_reader :token, :client
    end
  end
end