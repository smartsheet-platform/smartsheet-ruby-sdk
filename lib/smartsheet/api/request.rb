require 'smartsheet/api/url_builder'
require 'smartsheet/api/header_builder'
require 'smartsheet/api/body_builder'

module Smartsheet
  module API
    class Request
      def initialize(token, endpoint_spec, request_spec)
        @token = token
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def method
        endpoint_spec.method
      end

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

      private

      attr_reader :token, :endpoint_spec, :request_spec
    end
  end
end