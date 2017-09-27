require 'smartsheet/api/url_builder'
require 'smartsheet/api/header_builder'
require 'smartsheet/api/body_builder'

module Smartsheet
  module API
    class RequestBuilder
      def initialize(token, endpoint_spec, request_spec)
        @token = token
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def apply(req)
        req.url(url)
        req.headers = headers
        req.params = params
        req.body = body
      end

      private

      attr_reader :token, :endpoint_spec, :request_spec

      def url
        Smartsheet::API::UrlBuilder.new(endpoint_spec, request_spec).build
      end

      def headers
        Smartsheet::API::HeaderBuilder.new(token, endpoint_spec, request_spec).build
      end

      def params
        request_spec.params
      end

      def body
        Smartsheet::API::BodyBuilder.new(endpoint_spec, request_spec).build
      end
    end
  end
end