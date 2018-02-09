require_relative 'url_builder'

module Smartsheet
  module API
    # Specification for a single endpoint's configuration
    class EndpointSpec
      attr_reader :method, :url_segments, :spec

      # @param method [Symbol] The HTTP method for the endpoint; one of
      #   `[:get, :put, :post, :delete]`
      #
      # @param url_segments [Array<String, Symbol>] The segments of the endpoint URL; strings are
      #   added as literal segments, while symbols are mapped to corresponding values in a request
      #   specification
      # 
      # @param spec [Hash{Symbol=>Object}] Optional params, the following of which are supported:
      #
      #    - `:no_auth` - If specified as a key, the endpoint can be called without authentication.
      #        To preserve meaning, it is recommended to associate `:no_auth` with the value `true`.
      #
      #    - `:body_type` - If specified as a key, the endpoint will require a body to be provided
      #        by the request.  When associated with `:json`, it will expect a JSON formattable
      #        body.  When associated with `:file`, it will expect file upload parameters.
      #
      #    - `:headers` - When specified, this is expected to be a map of static HTTP headers that
      #        will be attached to each request.
      def initialize(method, url, **spec)
        @method = method
        @url_segments = url
        @spec = spec
      end

      def requires_auth?
        !spec.key?(:no_auth)
      end

      def requires_body?
        spec.key? :body_type
      end

      def sending_file?
        requires_body? && spec[:body_type] == :file
      end

      def sending_json?
        requires_body? && spec[:body_type] == :json
      end

      def headers
        spec.key?(:headers) ? spec[:headers] : {}
      end
    end
  end
end
