require 'smartsheet/api/url_builder'
require 'smartsheet/api/header_builder'
require 'smartsheet/api/body_builder'

module Smartsheet
  module API
    class Request
      attr_reader :method, :url, :headers, :params, :body

      def initialize(token, endpoint_spec, request_spec, assume_user)
        @method = endpoint_spec.method
        @url = Smartsheet::API::UrlBuilder.new(endpoint_spec, request_spec).build
        @headers = Smartsheet::API::HeaderBuilder.new(token, endpoint_spec, request_spec, assume_user).build
        @params = request_spec.params
        @body = Smartsheet::API::BodyBuilder.new(endpoint_spec, request_spec).build
      end

      def ==(other)
        other.class == self.class && other.equality_state == equality_state
      end

      protected

      def equality_state
        [method, url, headers, params, body]
      end
    end
  end
end