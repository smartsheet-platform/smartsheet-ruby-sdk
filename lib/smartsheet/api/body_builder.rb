module Smartsheet
  module API
    # Constructs bodies for accessing the Smartsheet API
    class BodyBuilder
      def initialize(endpoint_spec, request_spec)
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def build
        if endpoint_spec.sending_json?
          request_spec.json_body
        elsif endpoint_spec.sending_file?
          request_spec.file_body
        else
          request_spec.body
        end
      end

      private

      attr_accessor :endpoint_spec, :request_spec

    end
  end
end