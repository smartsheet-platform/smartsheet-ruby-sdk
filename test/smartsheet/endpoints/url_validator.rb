module Smartsheet
  module Test
    class UrlValidator
      def initialize(endpoint_spec, request_spec)
        @segments = endpoint_spec.url_segments
        @args = request_spec.url_args
      end

      def validate
        segment_vars = segments.select { |seg| seg.is_a? Symbol }
        arg_keys = args.keys

        validate_args_present(segment_vars, arg_keys)
        validate_args_match(segment_vars, arg_keys)

        true
      end

      private

      attr_accessor :segments, :args

      def validate_args_present(segment_vars, arg_keys)
        missing_args = segment_vars - arg_keys
        raise "Missing request parameters [#{missing_args}]" unless missing_args.empty?
      end

      def validate_args_match(segment_vars, arg_keys)
        extra_args = arg_keys - segment_vars
        raise "Unexpected request parameters [#{extra_args}]" unless extra_args.empty?
      end
    end
  end
end