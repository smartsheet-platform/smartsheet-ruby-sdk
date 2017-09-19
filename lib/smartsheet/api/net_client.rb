require_relative 'headers'
require_relative 'urls'

module Smartsheet
  module API
    class RequestBuilder
      def initialize(token, endpoint_spec, request_spec, req)
        @token = token
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
        @req = req
      end

      def apply
        build_url
        build_headers

        request_spec.attach_params(req)
        request_spec.attach_body(req)
      end

      private

      attr_accessor
      attr_reader :token, :endpoint_spec, :request_spec, :req

      def build_url
        Smartsheet::API::UrlBuilder
          .new
          .for_endpoint(endpoint_spec)
          .for_request(request_spec)
          .apply(req)
      end

      def build_headers
        Smartsheet::API::HeaderBuilder
          .new(token)
          .for_endpoint(endpoint_spec)
          .for_request(request_spec)
          .apply(req)
      end
    end

    class NetClient
      def initialize(token)
        @token = token
      end

      def send(endpoint_spec:, request_spec:)
        Faraday.send(endpoint_spec.method) do |req|
          RequestBuilder.new(token, endpoint_spec, request_spec, req).apply
        end
      end

      private

      attr_reader :token
    end
  end
end