require 'faraday'
require 'smartsheet/api/request_builder'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'

module Smartsheet
  module API
    class NetClient
      def initialize(token)
        @token = token
        create_connection
      end

      def make_request(endpoint_spec, request_spec)
        response = conn.send(endpoint_spec.method) do |req|
          RequestBuilder.new(token, endpoint_spec, request_spec, req).apply
        end
        response.body
      end

      private

      def create_connection
        @conn = Faraday.new do |conn|
          conn.request :multipart
          conn.request :url_encoded
          conn.use API::Middleware::ErrorTranslator
          conn.use API::Middleware::ResponseParser

          conn.adapter Faraday.default_adapter
        end
      end

      attr_reader :token, :conn
    end
  end
end