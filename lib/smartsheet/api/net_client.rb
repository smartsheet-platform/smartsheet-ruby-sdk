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
        build_params
        build_body
      end

      private

      attr_accessor
      attr_reader :token, :endpoint_spec, :request_spec, :req

      def build_url
        url =
          Smartsheet::API::UrlBuilder
          .new
          .for_endpoint(endpoint_spec)
          .for_request(request_spec)
          .build

        req.url(url)
      end

      def build_headers
        req.headers =
          Smartsheet::API::HeaderBuilder
          .new(token)
          .for_endpoint(endpoint_spec)
          .for_request(request_spec)
          .build
      end

      def build_params
        req.params = request_spec.params
      end

      def build_body
        req.body = request_spec.body if request_spec.body
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