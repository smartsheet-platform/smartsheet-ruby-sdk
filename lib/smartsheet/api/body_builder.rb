module Smartsheet
  module API
    # Constructs bodys for accessing the Smartsheet API
    class BodyBuilder
      def initialize(endpoint_spec, request_spec)
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def build
            simple_body
      end

      private

      attr_accessor :endpoint_spec, :request_spec

      def simple_body
        request_spec.body if request_spec.body
      end
    end
  end
end