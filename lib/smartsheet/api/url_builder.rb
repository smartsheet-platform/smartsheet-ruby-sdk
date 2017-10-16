require 'smartsheet/constants'

module Smartsheet
  module API
    # Constructs parameterized URLs for accessing the Smartsheet API
    class UrlBuilder
      def initialize(endpoint_spec, request_spec, base_url)
        @segments = endpoint_spec.url_segments
        @args = request_spec.url_args
        @base_url = base_url
      end

      def build
        segments
          .collect { |seg| seg.is_a?(Symbol) ? args[seg] : seg }
          .unshift(base_url)
          .join('/')
      end

      private

      attr_accessor :segments, :args, :base_url
    end
  end
end
