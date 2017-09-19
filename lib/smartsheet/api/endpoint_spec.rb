require_relative 'urls'

module Smartsheet
  module API
    class EndpointSpec
      REQUIRED_KEYS = %i[symbol method url].freeze
      OPTIONAL_KEYS = %i[has_params headers body_type].freeze

      attr_reader :symbol, :method

      def initialize(spec)
        @symbol, @method, @url = REQUIRED_KEYS.collect { |k| spec[k] }
        @spec = spec
        validate
      end

      def validate
        validate_keys
        validate_methods
      end

      def requires_body?
        spec.key? :body_type
      end

      def requires_path_args?
        url.any? { |segment| segment.is_a? Symbol }
      end

      def sending_json?
        accepts_body? && spec[:body_type] == :json
      end

      def url_segments
        url
      end

      def headers
        spec.key?(:headers) ? spec[:headers] : {}
      end

      private

      attr_reader :url, :spec

      def validate_keys
        missing_keys = REQUIRED_KEYS.reject { |key| spec.key? key }
        raise "Missing required endpoint spec keys: #{missing_keys}" unless missing_keys.empty?

        valid_keys = REQUIRED_KEYS + OPTIONAL_KEYS
        invalid_keys = spec.keys.reject { |k| valid_keys.include? k }
        raise "Invalid endpoint spec keys: #{invalid_keys}" unless invalid_keys.empty?
      end

      def validate_methods
        method = spec[:method]
        valid_methods = %i[get put post delete]
        is_method_valid = valid_methods.any? { |m| m == method }
        raise "Invalid endpoint method: #{method}" unless is_method_valid
      end

      def accepts_body?
        spec.key? :body_type
      end
    end
  end
end
