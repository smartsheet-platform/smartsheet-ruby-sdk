require 'faraday'
require 'json'
require_relative 'endpoint_spec'
require_relative 'request_spec'

module Smartsheet
  module API
    # Mixin module for declaring Smartsheet endpoints in a data-driven manner
    # Mixin expects:
    # - .client(): the client through which requests are made
    # Mixin provides:
    # - #def_endpoint(description)
    # - #def_endpoints(**descriptions)
    # - .make_request(description, params = {}, header_override = {}, body = nil, path_context = {})
    module Endpoints
      def self.extended(base)
        base.send(:define_method, :make_request) \
        do |endpoint_spec, params = {}, header_overrides = {}, body = nil, path_args = {}|
          request_spec =
            RequestSpec.new(
              path_args: path_args,
              params: params,
              header_overrides: header_overrides,
              body: body
            )

          client.send(endpoint_spec: endpoint_spec, request_spec: request_spec)
        end
      end

      # Creates an endpoint method.
      # `description` expects:
      # - symbol: the symbol of the method to create
      # - method: the HTTP method of the endpoint (:get | :put | :post | :delete)
      # - url: an array of string-convertible objects and symbol-placeholders representing URL path
      #     segments. Any symbols in this array will be expected as named parameters in the created
      #     method
      # - has_params (optional): if truthy, includes a 'params' argument for URL parameters
      # - headers (optional): a hash of additional headers this endpoint requires by default.
      #     This overrides universal Smartsheet request headers, and is overridden by any headers
      #     passed in by the SDK's client on call.
      # - body_type (optional): if non-nil, includes a 'body' argument for the request body.
      #     If assigned the value :json, the request will be setup to send JSON, and the body will
      #     be converted to json before being submitted
      def def_endpoint(description)
        spec = EndpointSpec.new(description)

        case [spec.requires_body?, spec.requires_path_args?]
        when [true,          true]
          def_full_endpoint(spec)
        when [true,          false]
          def_body_endpoint(spec)
        when [false,         true]
          def_path_endpoint(spec)
        when [false,         false]
          def_simple_endpoint(spec)
        else
          raise 'This should be exhaustive!'
        end
      end

      def def_full_endpoint(endpoint_spec)
        define_method endpoint_spec.symbol \
            do |params: {}, header_override: {}, body: nil, **path_context|
          make_request(endpoint_spec, params, header_override, body, path_context)
        end
      end

      def def_body_endpoint(endpoint_spec)
        define_method endpoint_spec.symbol do |params: {}, header_override: {}, body: nil|
          make_request(endpoint_spec, params, header_override, body)
        end
      end

      def def_path_endpoint(endpoint_spec)
        define_method endpoint_spec.symbol do |params: {}, header_override: {}, **path_context|
          make_request(endpoint_spec, params, header_override, nil, path_context)
        end
      end

      def def_simple_endpoint(endpoint_spec)
        define_method endpoint_spec.symbol do |params: {}, header_override: {}|
          make_request(endpoint_spec, params, header_override)
        end
      end

      # Creates endpoint methods based on the structure expected by def_endpoint. Accepts a
      # hashsplat of symbols to endpoint-descriptions-sans-symbols.
      def def_endpoints(**descriptions)
        descriptions.each do |symbol, description|
          def_endpoint({ symbol: symbol }.merge!(description))
        end
      end
    end
  end
end
