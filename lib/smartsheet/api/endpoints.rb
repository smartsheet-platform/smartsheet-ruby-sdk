require 'faraday'
require 'json'
require_relative 'urls'
require_relative 'headers'

module Smartsheet
  module API
    # Mixin module for declaring Smartsheet endpoints in a data-driven manner
    # Mixin expects:
    # - token(): the API token to attach to requests
    # Mixin provides:
    # - def_endpoint(description)
    # - make_request(description, params = {}, header_override = {}, body = nil, path_context = {})
    module Endpoints
      def self.extended(base)
        base.include Smartsheet::API::URLs
        base.include Smartsheet::API::Headers

        base.send(:define_method, :make_request) do |description, params = {}, header_override = {}, body = nil, path_context = {}|
          full_url = build_url(*description[:url], context: path_context)
          supports_body = !description[:body_type].nil?
          body_provided = !body.nil?
          sending_json = description[:body_type] == :json

          Faraday.send(description[:method], full_url, params) do |req|
            header_builder = build_headers(header_override)
            header_builder.endpoint_specific = description[:headers] if description[:headers]
            header_builder.sending_json if sending_json && body_provided
            header_builder.apply(req)

            if supports_body && body_provided
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
      # - has_params (optional): if set to a truthy value, includes a 'params' argument for URL
      #     parameters
      # - body_type: if non-null, includes a 'body' argument for the request body.
      #     If assigned the value :json, the request will be setup to send JSON, and the body will
      #     be converted to json before being submitted
      def def_endpoint(description)
        requires_path_context = description[:url].any? { |segment| segment.is_a? Symbol }

        if description[:body_type]
          if requires_path_context
            define_method description[:symbol] do |params: {}, header_override: {}, body: nil, **path_context|
              make_request(description, params, header_override, body, path_context)
            end
          else
            define_method description[:symbol] do |params: {}, header_override: {}, body: nil|
              make_request(description, params, header_override, body)
            end
          end
        elsif requires_path_context
          define_method description[:symbol] do |params: {}, header_override: {}, **path_context|
            make_request(description, params, header_override, nil, path_context)
          end
        else
          define_method description[:symbol] do |params: {}, header_override: {}|
            make_request(description, params, header_override)
          end
        end
      end
    end
  end
end
