require 'faraday'
require 'smartsheet/api/request'
require 'smartsheet/api/faraday_adapter/middleware/faraday_error_translator'
require 'smartsheet/api/faraday_adapter/middleware/response_parser'

module Smartsheet
  module API
    # Makes calls to the Smartsheet API through Faraday
    class FaradayNetClient
      def initialize
        create_connection
      end

      # Expected output:
      # - returned Success Response
      # - returned Error Response
      # - thrown Request Error
      def make_request(request)
        response = conn.send(request.method) do |req|
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
          conn.use Middleware::FaradayErrorTranslator
          conn.use Middleware::ResponseParser

          conn.adapter Faraday.default_adapter
        end
      end

      attr_reader :conn
    end
  end
end