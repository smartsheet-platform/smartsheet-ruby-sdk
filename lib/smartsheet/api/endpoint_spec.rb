require_relative 'url_builder'

module Smartsheet
  module API
    # Specification for a single endpoint's configuration
    class EndpointSpec
      attr_reader :method, :url_segments, :spec

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
