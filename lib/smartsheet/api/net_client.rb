require 'faraday'
require_relative 'request_builder'
require_relative 'retry_logic'
require_relative 'middleware/error_translator'
require_relative 'middleware/response_parser'

module Smartsheet
  module API
    class NetClient
      def initialize(token)
        @token = token
        create_connection
        create_retry_logic
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

      def create_connection
        @conn = Faraday.new do |faraday|
          faraday.use API::Middleware::ErrorTranslator
          faraday.use API::Middleware::ResponseParser
          faraday.adapter Faraday.default_adapter
        end
      end

      def create_retry_logic
        @retry_logic = RetryLogic.new do
          # call request check method here
          true
        end
      end

      attr_reader :token, :conn
    end
  end
end