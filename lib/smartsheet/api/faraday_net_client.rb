require 'faraday'
require 'smartsheet/api/request'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'

module Smartsheet
  module API
    class FaradayNetClient
      def initialize(token)
        @token = token
        create_connection
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(token, endpoint_spec, request_spec)

        response = conn.send(endpoint_spec.method) do |req|
          req.url(request.url)
          req.headers = request.headers
          req.params = request.params
          req.body = request.body
        end

        response.body
      end

      private

      def create_connection
        @conn = Faraday.new do |conn|
          conn.use API::Middleware::ErrorTranslator
          conn.use API::Middleware::ResponseParser

          conn.adapter Faraday.default_adapter
        end
      end

      attr_reader :token, :conn
    end
  end
end