require 'faraday'
require 'json'
require_relative 'urls'
require_relative 'headers'

module Smartsheet
  module API
    # Mixin module for declaring Smartsheet endpoints in a data-driven manner
    # Mixin expects:
    # - .token(): the API token to attach to requests
    # Mixin provides:
    # - #def_endpoint(description)
    # - #def_endpoints(**descriptions)
    # - .make_request(description, params = {}, header_override = {}, body = nil, path_context = {})
    module Endpoints
      def self.extended(base)
        base.include Smartsheet::API::URLs
        base.include Smartsheet::API::Headers

        base.send(:define_method, :make_request) \
        do |description, params = {}, header_override = {}, body = nil, path_context = {}|
          full_url = build_url(*description[:url], context: path_context)
          headers = description[:headers]
          supports_body = description.key? :body_type
          sending_json = description[:body_type] == :json

          Faraday.send(description[:method], full_url, params) do |req|
            header_builder = build_headers(header_override)
            header_builder.endpoint_specific = headers if headers
            header_builder.sending_json if sending_json && body
            header_builder.apply(req)

            if supports_body && body
              req.body = sending_json ? body.to_json : body
            end
          end
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
        has_body_type = description.key? :body_type
        requires_path_context = description[:url].any? { |segment| segment.is_a? Symbol }

        case [has_body_type, requires_path_context]
        when [true,          true]
          def_full_endpoint(description)
        when [true,          false]
          def_body_endpoint(description)
        when [false,         true]
          def_path_endpoint(description)
        when [false,         false]
          def_simple_endpoint(description)
        else
          raise 'This should be exhaustive!'
        end
      end

      def def_full_endpoint(description)
        define_method description[:symbol] \
            do |params: {}, header_override: {}, body: nil, **path_context|
          make_request(description, params, header_override, body, path_context)
        end
      end

      def def_body_endpoint(description)
        define_method description[:symbol] do |params: {}, header_override: {}, body: nil|
          make_request(description, params, header_override, body)
        end
      end

      def def_path_endpoint(description)
        define_method description[:symbol] do |params: {}, header_override: {}, **path_context|
          make_request(description, params, header_override, nil, path_context)
        end
      end

      def def_simple_endpoint(description)
        define_method description[:symbol] do |params: {}, header_override: {}|
          make_request(description, params, header_override)
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
