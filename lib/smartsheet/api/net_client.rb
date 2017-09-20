require 'faraday'
require_relative 'request_spec'
require_relative 'request_builder'

module Smartsheet
  module API
    class NetClient
      def initialize(token)
        @token = token
      end

      def make_request(endpoint_spec, request_spec)
        Faraday.send(endpoint_spec.method) do |req|
          RequestBuilder.new(token, endpoint_spec, request_spec, req).apply
        end
      end

      private

      attr_reader :token
    end
  end
end