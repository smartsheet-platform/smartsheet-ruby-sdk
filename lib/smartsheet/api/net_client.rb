require 'faraday'
require_relative 'request_spec'
require_relative 'request_builder'

module Smartsheet
  module API
    class NetClient
      def initialize(token)
        @token = token
      end

      def make_request(endpoint_spec, params: {}, header_overrides: {}, body: nil, **url_args)
        request_spec =
          RequestSpec.new(
            url_args: url_args,
            params: params,
            header_overrides: header_overrides,
            body: body
          )

        send(endpoint_spec: endpoint_spec, request_spec: request_spec)
      end

      private

      attr_reader :token

      def send(endpoint_spec:, request_spec:)
        Faraday.send(endpoint_spec.method) do |req|
          RequestBuilder.new(token, endpoint_spec, request_spec, req).apply
        end
      end
    end
  end
end