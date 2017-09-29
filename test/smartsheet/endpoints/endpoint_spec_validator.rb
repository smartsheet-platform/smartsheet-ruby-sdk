module Smartsheet
  module Test
    class EndpointSpecValidator
      VALID_METHODS = %i[get put post delete].freeze
      VALID_SPEC_KEYS = %i[headers body_type no_auth].freeze

      def initialize(endpoint_spec)
        @method = endpoint_spec.method
        @spec = endpoint_spec.spec
      end

      def validate
        validate_keys
        validate_methods

        true
      end

      private

      attr_reader :method, :spec

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