require 'smartsheet/constants'

module Smartsheet
  module API
    # Methods for building Smartsheet API URLs
    class UrlBuilder
      include Smartsheet::Constants

      def initialize(endpoint_spec, request_spec)
        @segments = endpoint_spec.url_segments
        @args = request_spec.url_args
      end

      def build
        segments
          .collect { |seg| seg.is_a?(Symbol) ? args[seg] : seg }
          .unshift(API_URL)
          .join('/')
      end

      private

      attr_accessor :segments, :args


    end
  end
end
