require_relative 'url_builder'

module Smartsheet
  module API
    class EndpointSpec
      VALID_METHODS = %i[get put post delete].freeze
      VALID_SPEC_KEYS = %i[headers body_type no_auth].freeze

      attr_reader :method, :url_segments

      def initialize(method, url, **spec)
        @method = method
        @url_segments = url
        @spec = spec

        validate
      end

      def validate
        validate_keys
        validate_methods
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

      private

      attr_reader :spec

      def validate_keys
        invalid_keys = spec.keys - VALID_SPEC_KEYS
        raise "Invalid endpoint spec keys: #{invalid_keys}" unless invalid_keys.empty?
      end

      def validate_methods
        is_method_valid = VALID_METHODS.any? { |m| m == method }
        raise "Invalid endpoint method: #{method}" unless is_method_valid
      end
    end
  end
end
