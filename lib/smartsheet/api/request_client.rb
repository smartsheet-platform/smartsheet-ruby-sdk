module Smartsheet
  module API
    class RequestClient
      def initialize(token, client)
        @token = token
        @client = client
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(token, endpoint_spec, request_spec)
        client.make_request(request)
      end

      private

      attr_reader :token, :client
    end
  end
end