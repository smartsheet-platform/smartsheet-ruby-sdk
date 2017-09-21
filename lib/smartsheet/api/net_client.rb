require_relative 'request_builder'
require_relative 'retry_logic'

module Smartsheet
  module API
    class NetClient
      def initialize(token, conn)
        @token = token
        @conn = conn
        @retry_logic = RetryLogic.new do
          # call request check method here
          true
        end
      end

      def make_request(endpoint_spec, request_spec)
        @retry_logic.run do
          _make_request(endpoint_spec, request_spec)
        end
      end

      private

      def _make_request(endpoint_spec, request_spec)
        response = conn.send(endpoint_spec.method) do |req|
          RequestBuilder.new(token, endpoint_spec, request_spec, req).apply
        end
        response.body
      end

      attr_reader :token, :conn
    end
  end
end