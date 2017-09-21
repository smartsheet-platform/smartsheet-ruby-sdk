require 'faraday'
require_relative 'request_spec'
require_relative 'request_builder'
require_relative 'retry_logic'

module Smartsheet
  module API
    class NetClient
      def initialize(token)
        @token = token
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
        Faraday.send(endpoint_spec.method) do |req|
          RequestBuilder.new(token, endpoint_spec, request_spec, req).apply
        end
      end

      attr_reader :token
    end
  end
end