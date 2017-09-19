module Smartsheet
  module API
    # Methods for building Smartsheet API URLs
    class UrlBuilder
      API_URL = 'https://api.smartsheet.com/2.0'.freeze

      def initialize
        @segments = nil
        @args = nil
      end

      def for_endpoint(endpoint_spec)
        self.segments = endpoint_spec.url_segments
        self
      end

      def for_request(request_spec)
        self.args = request_spec.path_args
        self
      end

      def build
        validate_spec_compatibility

        segments
          .collect { |seg| seg.is_a?(Symbol) ? args[seg] : seg }
          .unshift(API_URL)
          .join('/')
      end

      private

      attr_accessor :segments, :args

      def validate_spec_compatibility
        segment_vars = segments.select { |seg| seg.is_a? Symbol }.to_set
        arg_keys = args.keys.to_set

        validate_args_present(segment_vars, arg_keys)
        validate_args_match(segment_vars, arg_keys)
      end

      def validate_args_present(segment_vars, arg_keys)
        missing_args = segment_vars - arg_keys
        return if missing_args.empty?

        missing_args_string = missing_args.to_a.join(', ')
        raise "Missing request parameters [#{missing_args_string}]"
      end

      def validate_args_match(segment_vars, arg_keys)
        extra_args = arg_keys - segment_vars
        return if extra_args.empty?

        extra_args_string = extra_args.to_a.join(', ')
        raise "Unexpected request parameters [#{extra_args_string}]"
      end
    end
  end
end
